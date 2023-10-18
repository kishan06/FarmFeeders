import 'dart:convert';
import 'dart:developer';

import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/frams_info_map.dart';
import 'package:farmfeeders/models/FarmInfoModel/FarmInfoModel.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:farmfeeders/view_models/FarmInfoApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/custom_button_curve.dart';
import '../models/AddressModel/search_responce_model.dart';
import 'farmInfoAddress.dart';
import 'placeServices/place_services.dart';
import 'search_address_details.dart';

class FarmsInfo extends StatefulWidget {
  const FarmsInfo({super.key});

  @override
  State<FarmsInfo> createState() => _FarmsInfoState();
}

class _FarmsInfoState extends State<FarmsInfo> {
  FramsInfoMap framsInfoMapController = Get.put(FramsInfoMap());
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  int farmNumber = 0;
  final placesService = PlacesService();
  final GlobalKey<FormState> _formdairy = GlobalKey<FormState>();

  String lat = "";
  String lng = "";
  List<Prediction> searchResults = [];
  bool searchClear = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Farms Info"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 25.h),
        child: customButtonCurve(
            text: "Next",
            onTap: () {
              final isValid = _formdairy.currentState?.validate();
              if (isValid!) {
                Utils.loader();
                FarmInfoApi()
                    .farmInfoAddressApi(
                        framsInfoMapController.farmInfoAddressModel)
                    .then((value) {
                  Get.back();
                  isSetFarmInfo = true;
                  Get.toNamed("/letsSetUpYourFarm");
                });
              }

              // Get.back();
              // Get.toNamed("/ResetPassword");
            }),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formdairy,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
            child: Column(
              children: [
                sizedBoxHeight(15.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: textBlack16W5000("How many plots of land do u farm?"),
                ),

                sizedBoxHeight(8.h),

                CustomTextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    return null;
                  },
                  // leadingIcon:
                  //     SvgPicture.asset("assets/images/password.svg"),
                  hintText: "Enter No of farms",
                  validatorText: "Required",
                  texttype: TextInputType.number,
                  onChanged: (value) {
                    framsInfoMapController.addressList.clear();
                    framsInfoMapController.farmInfoAddressModel =
                        FarmInfoAddressModel(farmCount: 0, farms: []);
                    setState(() {
                      log(value);
                      if (value.isNotEmpty) {
                        farmNumber = int.tryParse(value) ?? 1;
                        framsInfoMapController.addressList = List.generate(
                            farmNumber, (_) => TextEditingController());
                      } else {
                        farmNumber = 0;
                      }
                    });
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                    LimitRange(1, 20)
                  ],
                  // isInputPassword: true,
                ),

                sizedBoxHeight(30.h),

                framsInfoMapController.addressList.isEmpty
                    ? SizedBox()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: textBlack16W5000("Where is your farm located ?"),
                      ),

                sizedBoxHeight(8.h),

                SizedBox(
                  height: Get.height / 1.8,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: farmNumber,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CustomTextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                textEditingController:
                                    framsInfoMapController.addressList[index],
                                readonly: true,
                                onTap: () {
                                  framsInfoMapController.farmInfoAddressModel
                                      .farmCount = farmNumber;
                                  framsInfoMapController
                                      .selectedAddressIndex.value = index;
                                  if (framsInfoMapController
                                      .farmInfoAddressModel.farms!.isNotEmpty) {
                                    if (framsInfoMapController
                                            .farmInfoAddressModel
                                            .farms!
                                            .length >
                                        index) {
                                      if (framsInfoMapController
                                          .farmInfoAddressModel
                                          .farms![index]
                                          .farmAddress!
                                          .isNotEmpty) {
                                        framsInfoMapController
                                                .streetTextEditingController
                                                .text =
                                            framsInfoMapController
                                                .farmInfoAddressModel
                                                .farms![index]
                                                .street!;

                                        framsInfoMapController
                                                .cityTextEditingController
                                                .text =
                                            framsInfoMapController
                                                .farmInfoAddressModel
                                                .farms![index]
                                                .city!;

                                        framsInfoMapController
                                                .provinceTextEditingController
                                                .text =
                                            framsInfoMapController
                                                .farmInfoAddressModel
                                                .farms![index]
                                                .province!;

                                        framsInfoMapController
                                                .postalCodeTextEditingController
                                                .text =
                                            framsInfoMapController
                                                .farmInfoAddressModel
                                                .farms![index]
                                                .postalCode!;

                                        framsInfoMapController
                                                .countryTextEditingController
                                                .text =
                                            framsInfoMapController
                                                .farmInfoAddressModel
                                                .farms![index]
                                                .country!;
                                        framsInfoMapController
                                                .addressController.text =
                                            framsInfoMapController
                                                .farmInfoAddressModel
                                                .farms![index]
                                                .farmAddress!;
                                      } else {
                                        framsInfoMapController
                                            .streetTextEditingController
                                            .clear();
                                        framsInfoMapController
                                            .cityTextEditingController
                                            .clear();
                                        framsInfoMapController
                                            .provinceTextEditingController
                                            .clear();
                                        framsInfoMapController
                                            .postalCodeTextEditingController
                                            .clear();
                                        framsInfoMapController
                                            .countryTextEditingController
                                            .clear();
                                        framsInfoMapController.addressController
                                            .clear();
                                      }
                                    } else {
                                      framsInfoMapController
                                          .streetTextEditingController
                                          .clear();
                                      framsInfoMapController
                                          .cityTextEditingController
                                          .clear();
                                      framsInfoMapController
                                          .provinceTextEditingController
                                          .clear();
                                      framsInfoMapController
                                          .postalCodeTextEditingController
                                          .clear();
                                      framsInfoMapController
                                          .countryTextEditingController
                                          .clear();
                                      framsInfoMapController.addressController
                                          .clear();
                                    }
                                  } else {
                                    framsInfoMapController
                                        .streetTextEditingController
                                        .clear();
                                    framsInfoMapController
                                        .cityTextEditingController
                                        .clear();
                                    framsInfoMapController
                                        .provinceTextEditingController
                                        .clear();
                                    framsInfoMapController
                                        .postalCodeTextEditingController
                                        .clear();
                                    framsInfoMapController
                                        .countryTextEditingController
                                        .clear();
                                    framsInfoMapController.addressController
                                        .clear();
                                  }

                                  Get.to(() => const FarmInfoAddressScreen());
                                },
                                hintText: "Select on map",
                                validatorText: "Required",
                                // texttype: TextInputType.phone,
                                leadingIcon: SvgPicture.asset(
                                  "assets/images/location.svg",
                                ),
                              ),
                              sizedBoxHeight(15.h)
                            ],
                          );
                        }),
                  ),
                ),
                // CustomTextFormField(
                //   hintText: "Enter your farm location",
                //   validatorText: "",
                //   // texttype: TextInputType.phone,
                //   leadingIcon: SvgPicture.asset(
                //     "assets/images/location.svg",
                //   ),
                // ),

                // Spacer(),

                // sizedBoxHeight(120.h)
              ],
            ),
          ),
        )),
      ),
    );
  }

  Padding cards(
      {void Function()? onTap,
      required String imagePath,
      required String title,
      required String des}) {
    return Padding(
      padding: EdgeInsets.only(top: 25.h),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 358.w,
              height: 108.h,
              decoration: BoxDecoration(
                  color:
                      // AppColors.black,
                      AppColors.greyF1F1F1,
                  borderRadius: BorderRadius.circular(10.h),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.greyF2F4F5,
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.fromLTRB(100.w, 5.h, 5.w, 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textBlack20W7000Mon(title),
                    sizedBoxHeight(9.h),
                    textBlack16(des)
                  ],
                ),
              ),
            ),
            Positioned(
              top: -25.h,
              // left: -6.w,
              child: Container(
                width: 85.w,
                height: 108.h,
                decoration: BoxDecoration(
                    // color:AppColors.greyF1F1F1,
                    image: DecorationImage(
                        image: AssetImage(
                          imagePath,
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(5.h),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.greyF2F4F5,
                        blurRadius: 6,
                        spreadRadius: 3,
                      )
                    ]),
                // child: Padding(
                //   padding: EdgeInsets.fromLTRB(100.w, 5.h, 5.w, 5.h),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       textBlack20W7000Mon(title),
                //       sizedBoxHeight(9.h),
                //       textBlack16(des)
                //     ],
                //   ),
                // ),
              ),

              // Image.asset(
              //   imagePath,
              //   height: 108.h,
              //   width: 85.w,
              // ),
            )
          ],
        ),
      ),
    );
  }
}
