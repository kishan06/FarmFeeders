import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/view/Side%20Menu/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Utils/custom_button.dart';

  bool isSetFarmInfo = false;
  // bool get isSetFarmInfo => isSetFarmInfo;

  bool isSetLiveStockInfo = false;
  // bool get isSetLiveStockInfo => isSetLiveStockInfo;
  
  bool isSetFeedInfo = false;
  // bool get isSetFeedInfo => _isSetFeedInfo;

class LetsSetUpYourFarm extends StatefulWidget {
  const LetsSetUpYourFarm({super.key});

  @override
  State<LetsSetUpYourFarm> createState() => _LetsSetUpYourFarmState();
}

class _LetsSetUpYourFarmState extends State<LetsSetUpYourFarm> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincode = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Lets Set Up Your Farm"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              sizedBoxHeight(15.h),
              cards(
                onTap: () {
                  Get.toNamed("/farmsInfo");
                },
                set: isSetFarmInfo,
                imagePath: "assets/images/setupFarm1.png",
                title: "Farm Information",
                des: "Lorem Ipsum Is Simply Dummy",
              ),
              sizedBoxHeight(25.h),
              cards(
                onTap: () {
                  Get.toNamed("/livestockinfomain");
                },
                set: isSetLiveStockInfo,
                imagePath: "assets/images/setupFarm2.png",
                title: "Livestock Information",
                des: "Lorem Ipsum Is Simply Dummy",
              ),
              
              sizedBoxHeight(25.h),

              cards(
                onTap: (){
                  Get.toNamed("/farmfeedtracker");
                },
                set: isSetFeedInfo,
                imagePath: "assets/images/setupFarm3.png",
                title: "Feed Information",
                des: "Lorem Ipsum Is Simply Dummy",
              ),

              (isSetFarmInfo && isSetLiveStockInfo && isSetFeedInfo)
                ?sizedBoxHeight(100.h)
                :sizedBoxHeight(35.h),

              (isSetFarmInfo && isSetLiveStockInfo && isSetFeedInfo)
                ? CustomButton(
                  text: "Procced To Dashboard",
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (context) => addCommunityDailog()
                    );
                  }
                )
                :GestureDetector(
                    onTap: () {
                      Get.to(SideMenu());
                    },
                    child: textGreen16W700("Skip & Procced to dashboard")
                )

              // textBlack16(text)
            ],
          ),
        ),
      )),
    );
  }

  Padding cards(
      {void Function()? onTap,
      required String imagePath,
      required String title,
      required bool set,
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
                  color: set ? AppColors.buttoncolour :
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // icon
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.check_circle_outline,
                        size: 19.w,
                        color: set ? AppColors.white : AppColors.transparent,
                      ),
                    ),
                    set ? textWhite20W7000Mon(title):textBlack20W7000Mon(title),
                    // sizedBoxHeight(9.h),
                    set ? textWhite16(des) : textBlack16(des)
                  ],
                ),
              ),
            ),
            Positioned(
              top: -25.h,
              // left: -6.w,
              child: Container(
                width: 85.w,
                height: 120.h,
                decoration: BoxDecoration(
                    // color:AppColors.greyF1F1F1,
                    image: DecorationImage(
                        image: AssetImage(
                          imagePath,
                        ),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(5.h),
                    // boxShadow: const [
                    //   BoxShadow(
                    //     color: AppColors.greyF2F4F5,
                    //     blurRadius: 6,
                    //     spreadRadius: 3,
                    //   )
                    // ]
                    ),
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

  Widget addCommunityDailog() {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              color: AppColors.white,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 25.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          size: 30.h,
                          color: AppColors.grey4D4D4D,
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight(35.h),

                  textBlack25W600Mon("Thank You!"),

                  sizedBoxHeight(15.h),
                  
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      
                      text: 'Thank you for creating account with ',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Farm Feed.', 
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.buttoncolour,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  sizedBoxHeight(40.h),

                  SizedBox(
                    width: 270.w,
                    child: CustomButton(text: "Go To Dashboard",
                      onTap: (){
                        // Get.to(() => SideMenu());
                        Get.toNamed("/sideMenu");

                      }
                    ),
                  ),

                  sizedBoxHeight(40.h),



                ],
              ),
            ),
          ),
          Positioned.fill(
            top: -60.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: AppColors.buttoncolour,
                radius: 60.h,
                child: SvgPicture.asset("assets/images/wareHouse.svg",
                  height: 60.h,
                  width: 60.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
