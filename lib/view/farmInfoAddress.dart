import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/controller/frams_info_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Utils/texts.dart';
import '../common/CommonTextFormField.dart';
import '../common/custom_button_curve.dart';
import '../models/AddressModel/search_responce_model.dart';
import '../models/FarmInfoModel/FarmInfoModel.dart';
import 'placeServices/place_services.dart';
import 'search_address_details.dart';

class FarmInfoAddressScreen extends StatefulWidget {
  const FarmInfoAddressScreen({super.key});

  @override
  State<FarmInfoAddressScreen> createState() => _FarmInfoAddressScreenState();
}

class _FarmInfoAddressScreenState extends State<FarmInfoAddressScreen> {
  late GoogleMapController mapController;
  Marker? selectedMarker;
  double? selectedLatitude;
  double? selectedLongitude;
  FramsInfoMap framsInfoMapController = Get.put(FramsInfoMap());
  String lat = "";
  String lng = "";
  List<Prediction> searchResults = [];
  bool searchClear = true;
  final placesService = PlacesService();
  final GlobalKey<FormState> _formdairy = GlobalKey<FormState>();
  static const LatLng dublin = LatLng(53.349805, -6.26031);
  static LatLngBounds irelandBounds = LatLngBounds(
      southwest: const LatLng(51.451275, -6.808388),
      northeast: const LatLng(55.1316222195, -6.03298539878));
// {'Ireland': [-9.97708574059, 51.6693012559, -6.03298539878, 55.1316222195]}},
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
            preferredSize: Size(Get.width, 56),
            child: Container(
                margin: const EdgeInsets.only(top: 15),
                child:
                    customAppBar(text: "Choose On Map", inBottomSheet: false))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),

          // padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formdairy,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // textBlack16("asd")

                  // sizedBoxHeight(10.h),

                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Address";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: framsInfoMapController.addressController,
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    cursorWidth: 1.5,
                    decoration: InputDecoration(
                      counterText: '',
                      alignLabelWithHint: true,
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black45),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.black45),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      //  errorText: "Please Enter Address",
                      hintText: "Enter Address",
                      hintStyle:
                          const TextStyle(color: Colors.black54, fontSize: 14),
                      // contentPadding:
                      //     const EdgeInsets.only(left: 16),
                      suffixIcon:
                          framsInfoMapController.addressController.text.isEmpty
                              ? null
                              : GestureDetector(
                                  onTap: () {
                                    print('clear search done');
                                    framsInfoMapController.addressController
                                        .clear();
                                    //FocusScope.of(context).unfocus();
                                    setState(() {});
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Icon(
                                      Icons.cancel_sharp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                    ),
                    onChanged: (value) async {
                      searchClear = value.isEmpty;
                      await placesService.getAutocomplete(value).then((value) {
                        final searchResponse = searchAddressListFromJson(value);

                        searchResults = searchResponse.predictions!;
                      });
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: (!searchClear &&
                            framsInfoMapController
                                .addressController.text.isNotEmpty)
                        ? 12
                        : 0,
                  ),
                  Visibility(
                    visible: !searchClear &&
                        framsInfoMapController
                            .addressController.text.isNotEmpty,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.91,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                contentPadding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                title: Text(
                                  // change
                                  searchResults[index].description.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                onTap: () async {
                                  setState(() {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    searchClear = true;
                                    String id =
                                        searchResults[index].placeId.toString();
                                    placesService
                                        .getPlace(id)
                                        .then((value) async {
                                      final searchResponse =
                                          searchAddressDetailsFromJson(value);

                                      selectedLatitude = searchResponse
                                          .result!.geometry!.location!.lat;
                                      selectedLongitude = searchResponse
                                          .result!.geometry!.location!.lng;

                                      framsInfoMapController
                                              .addressController.text =
                                          searchResponse
                                              .result!.formattedAddress!;

                                      final addresses =
                                          await placemarkFromCoordinates(
                                        searchResponse
                                            .result!.geometry!.location!.lat!,
                                        searchResponse
                                            .result!.geometry!.location!.lng!,
                                      );

                                      if (addresses.isNotEmpty) {
                                        final selectedAddress = addresses.first;

                                        final address =
                                            "${selectedAddress.street}, ${selectedAddress.locality}, ${selectedAddress.country}";
                                        framsInfoMapController
                                            .addressController.text = address;
                                        framsInfoMapController
                                            .streetTextEditingController
                                            .text = selectedAddress.street!;
                                        framsInfoMapController
                                            .countryTextEditingController
                                            .text = selectedAddress.country!;
                                        framsInfoMapController
                                            .postalCodeTextEditingController
                                            .text = selectedAddress.postalCode!;
                                        framsInfoMapController
                                                .provinceTextEditingController
                                                .text =
                                            selectedAddress.administrativeArea!;
                                        framsInfoMapController
                                            .cityTextEditingController
                                            .text = selectedAddress.locality!;
                                      }

                                      LatLng mPostion = LatLng(
                                          searchResponse
                                              .result!.geometry!.location!.lat!,
                                          searchResponse.result!.geometry!
                                              .location!.lng!);
                                      CameraPosition cameraPosition =
                                          CameraPosition(
                                              target: mPostion, zoom: 17);

                                      setState(() {
                                        selectedMarker = Marker(
                                          markerId: const MarkerId(
                                              'selected_location'),
                                          position: mPostion,
                                        );
                                        selectedLatitude = searchResponse
                                            .result!.geometry!.location!.lat!;
                                        selectedLongitude = searchResponse
                                            .result!.geometry!.location!.lng!;
                                      });
                                      mapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                              cameraPosition));
                                    });
                                  });
                                },
                              ),
                              const Divider(
                                color: Colors.black,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  sizedBoxHeight(10.h),
                  textBlack18W5000("Drag the map to choose a place"),

                  sizedBoxHeight(10.h),

                  SizedBox(
                    width: double.infinity, height: 300.h,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      // myLocationEnabled: true,
                      // myLocationButtonEnabled: true,
                      cameraTargetBounds: CameraTargetBounds(irelandBounds),
                      initialCameraPosition: const CameraPosition(
                        target: dublin,
                        zoom: 7,
                      ),
                      scrollGesturesEnabled: true,
                      gestureRecognizers: Set()
                        ..add(Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer())),
                      markers: Set<Marker>.of(
                          selectedMarker != null ? [selectedMarker!] : []),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;

                        if (framsInfoMapController
                            .farmInfoAddressModel.farms!.isNotEmpty) {
                          if (framsInfoMapController
                                  .farmInfoAddressModel.farms!.length >
                              framsInfoMapController
                                  .selectedAddressIndex.value) {
                            LatLng mPostion = LatLng(
                                framsInfoMapController
                                    .farmInfoAddressModel
                                    .farms![framsInfoMapController
                                        .selectedAddressIndex.value]
                                    .farmLatitude!,
                                framsInfoMapController
                                    .farmInfoAddressModel
                                    .farms![framsInfoMapController
                                        .selectedAddressIndex.value]
                                    .farmLongitude!);
                            CameraPosition cameraPosition =
                                CameraPosition(target: mPostion, zoom: 17);
                            setState(() {
                              selectedMarker = Marker(
                                markerId: const MarkerId('selected_location'),
                                position: mPostion,
                              );
                            });
                            mapController.animateCamera(
                                CameraUpdate.newCameraPosition(cameraPosition));
                          }
                        }
                      },
                      onTap: (LatLng latLng) async {
                        final addresses = await placemarkFromCoordinates(
                          latLng.latitude,
                          latLng.longitude,
                        );

                        if (addresses.isNotEmpty) {
                          final selectedAddress = addresses.first;

                          final address =
                              "${selectedAddress.street}, ${selectedAddress.locality}, ${selectedAddress.country}";
                          framsInfoMapController.addressController.text =
                              address;
                          framsInfoMapController.streetTextEditingController
                              .text = selectedAddress.street!;
                          framsInfoMapController.countryTextEditingController
                              .text = selectedAddress.country!;
                          framsInfoMapController.postalCodeTextEditingController
                              .text = selectedAddress.postalCode!;
                          framsInfoMapController.provinceTextEditingController
                              .text = selectedAddress.administrativeArea!;
                          framsInfoMapController.cityTextEditingController
                              .text = selectedAddress.locality!;
                          setState(() {
                            selectedMarker = Marker(
                              markerId: const MarkerId('selected_location'),
                              position: latLng,
                            );
                            selectedLatitude = latLng.latitude;
                            selectedLongitude = latLng.longitude;
                          });

                          print('Selected Address: $address');
                          print('Latitude: $selectedLatitude');
                          print('Longitude: $selectedLongitude');
                        }
                      },
                    ),

                    // SvgPicture.asset("assets/images/map.svg",
                    //   // height: 350.h,
                    //   // width: 358.w,
                    //   fit: BoxFit.fill,
                    // ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight(10.h),
                      textBlack16W5000("Street"),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                        textEditingController:
                            framsInfoMapController.streetTextEditingController,
                        // leadingIcon:
                        //     SvgPicture.asset("assets/images/password.svg"),
                        hintText: "Street",
                        validatorText: "street required",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Street Required";
                          }
                          return null;
                        },
                        texttype: TextInputType.text,
                      ),
                      sizedBoxHeight(10.h),
                      textBlack16W5000("City"),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                        textEditingController:
                            framsInfoMapController.cityTextEditingController,
                        // leadingIcon:
                        //     SvgPicture.asset("assets/images/password.svg"),
                        hintText: "City",
                        validatorText: "",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "City Required";
                          }
                          return null;
                        },
                        texttype: TextInputType.text,
                      ),
                      sizedBoxHeight(10.h),
                      textBlack16W5000("Province"),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                        textEditingController: framsInfoMapController
                            .provinceTextEditingController,
                        // leadingIcon:
                        //     SvgPicture.asset("assets/images/password.svg"),
                        hintText: "Province",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Province Required";
                          }
                          return null;
                        },
                        validatorText: "",
                        texttype: TextInputType.text,
                      ),
                      sizedBoxHeight(10.h),
                      textBlack16W5000("Postal Code"),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                        textEditingController: framsInfoMapController
                            .postalCodeTextEditingController,
                        // leadingIcon:
                        //     SvgPicture.asset("assets/images/password.svg"),
                        hintText: "Postal Code",
                        validatorText: "",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Postal Code Required";
                          }
                          return null;
                        },
                        texttype: TextInputType.text,
                      ),
                      sizedBoxHeight(10.h),
                      textBlack16W5000("Country"),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                        textEditingController:
                            framsInfoMapController.countryTextEditingController,
                        // leadingIcon:
                        //     SvgPicture.asset("assets/images/password.svg"),
                        hintText: "Country",
                        validatorText: "",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Country Required";
                          }
                          return null;
                        },
                        texttype: TextInputType.text,
                      ),
                    ],
                  ),

                  sizedBoxHeight(10.h),

                  // textg
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 15.h,
              bottom: MediaQuery.of(context).viewInsets.bottom == 0
                  ? 15.h
                  : MediaQuery.of(context).viewInsets.bottom + 15),
          child: SizedBox(
            width: Get.width / 1,
            height: 50,
            child: customButtonCurve(
                text: "Update",
                onTap: () {
                  final isValid = _formdairy.currentState?.validate();
                  if (isValid!) {
                    framsInfoMapController
                            .addressList[framsInfoMapController
                                .selectedAddressIndex.value]
                            .text =
                        "${framsInfoMapController.streetTextEditingController.text}, ${framsInfoMapController.cityTextEditingController.text}, ${framsInfoMapController.provinceTextEditingController.text}, ${framsInfoMapController.postalCodeTextEditingController.text}, ${framsInfoMapController.countryTextEditingController.text}";
                    if (framsInfoMapController
                        .farmInfoAddressModel.farms!.isNotEmpty) {
                      if (framsInfoMapController
                              .farmInfoAddressModel.farms!.length >
                          framsInfoMapController.selectedAddressIndex.value) {
                        framsInfoMapController.farmInfoAddressModel.farms![
                            framsInfoMapController
                                .selectedAddressIndex.value] = Farms(
                          city: framsInfoMapController
                              .cityTextEditingController.text,
                          country: framsInfoMapController
                              .countryTextEditingController.text,
                          postalCode: framsInfoMapController
                              .postalCodeTextEditingController.text,
                          province: framsInfoMapController
                              .provinceTextEditingController.text,
                          street: framsInfoMapController
                              .streetTextEditingController.text,
                          farmAddress:
                              framsInfoMapController.addressController.text,
                          farmLatitude: selectedLatitude,
                          farmLongitude: selectedLongitude,
                        );
                      } else {
                        framsInfoMapController.farmInfoAddressModel.farms!
                            .add(Farms(
                          city: framsInfoMapController
                              .cityTextEditingController.text,
                          country: framsInfoMapController
                              .countryTextEditingController.text,
                          postalCode: framsInfoMapController
                              .postalCodeTextEditingController.text,
                          province: framsInfoMapController
                              .provinceTextEditingController.text,
                          street: framsInfoMapController
                              .streetTextEditingController.text,
                          farmAddress:
                              framsInfoMapController.addressController.text,
                          farmLatitude: selectedLatitude,
                          farmLongitude: selectedLongitude,
                        ));
                      }
                    } else {
                      framsInfoMapController.farmInfoAddressModel.farms!
                          .add(Farms(
                        city: framsInfoMapController
                            .cityTextEditingController.text,
                        country: framsInfoMapController
                            .countryTextEditingController.text,
                        postalCode: framsInfoMapController
                            .postalCodeTextEditingController.text,
                        province: framsInfoMapController
                            .provinceTextEditingController.text,
                        street: framsInfoMapController
                            .streetTextEditingController.text,
                        farmAddress:
                            framsInfoMapController.addressController.text,
                        farmLatitude: selectedLatitude,
                        farmLongitude: selectedLongitude,
                      ));
                    }

                    Get.back();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
