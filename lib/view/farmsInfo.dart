import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../common/custom_button_curve.dart';

class FarmsInfo extends StatefulWidget {
  const FarmsInfo({super.key});

  @override
  State<FarmsInfo> createState() => _FarmsInfoState();
}

class _FarmsInfoState extends State<FarmsInfo> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  int farmNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Farms Info"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                // leadingIcon:
                //     SvgPicture.asset("assets/images/password.svg"),
                hintText: "Enter No of farms",
                validatorText: "",
                texttype: TextInputType.phone,
                onChanged: (value) {
                  // farmNumber = int.tryParse(value)??1;
                  setState(() {
                    farmNumber = int.tryParse(value) ?? 1;
                  });
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                  LimitRange(1, 20)
                ],
                // isInputPassword: true,
              ),

              sizedBoxHeight(30.h),

              Align(
                alignment: Alignment.centerLeft,
                child: textBlack16W5000("Where is your farm located ?"),
              ),

              sizedBoxHeight(8.h),

              // List.generate
              SizedBox(
                height: 400.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ListView.builder(
                      itemCount: farmNumber,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CustomTextFormField(
                              readonly: true,
                              onTap: () {
                                locationBottomSheet();
                              },
                              hintText: "Select on map",
                              validatorText: "",
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

              customButtonCurve(
                  text: "Next",
                  onTap: () {
                    isSetFarmInfo = true;
                    Get.toNamed("/letsSetUpYourFarm");

                    // Get.back();
                    // Get.toNamed("/ResetPassword");
                  }),

              // sizedBoxHeight(120.h)
            ],
          ),
        )),
      ),
    );
  }

  Future<T?> locationBottomSheet<T>() {
    late GoogleMapController mapController;
    Marker? selectedMarker;
    double? selectedLatitude;
    double? selectedLongitude;
    return Get.bottomSheet(
        Container(
            height: 700.h,
            // color: AppColors.white,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h))),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),

              // padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // textBlack16("asd")
                  customAppBar(text: "Choose On Map", inBottomSheet: true),

                  sizedBoxHeight(10.h),

                  textBlack18W5000("Drag the map to choose a place"),

                  sizedBoxHeight(10.h),

                  Expanded(
                    child: Container(
                      // color: Colors.amber,
                      // height: 400.h,
                      // width: 358.w,
                      width: double.infinity,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(37.7749,
                              -122.4194), // Initial map location (San Francisco)
                          zoom: 12.0,
                        ),
                        markers: Set<Marker>.of(
                            selectedMarker != null ? [selectedMarker!] : []),
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
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
                            setState(() {
                              selectedMarker = Marker(
                                markerId: MarkerId('selected_location'),
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
                  ),

                  sizedBoxHeight(10.h),

                  Row(
                    children: [
                      Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusDirectional.circular(5.w),
                            color: AppColors.buttoncolour),
                        child: Icon(
                          Icons.near_me,
                          color: AppColors.white,
                          size: 20.w,
                        ),
                      ),
                      sizedBoxWidth(5.w),
                      textBlack18("Dopped Pin"),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                      )
                    ],
                  ),

                  Divider(
                    thickness: 1.h,
                    color: AppColors.black,
                  ),

                  textGrey4D4D4D_16("Suggestions"),

                  textBlack18("Dopped Pin"),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.buttoncolour,
                        size: 20.w,
                      ),

                      sizedBoxWidth(5.w),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textBlack16("Decathlon Malad"),
                          // textGrey4D4D4D_16(text)
                          textGrey4D4D4D_14(
                              "22b baker street St, Marylebone, Europe")
                        ],
                      ),

                      // textBlack18("Dopped Pin"),

                      const Spacer(),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                      )
                    ],
                  ),

                  // textg
                ],
              ),
            )),
        // barrierColor: Colors.red[50],
        // isDismissible: false,
        isScrollControlled: true);
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
