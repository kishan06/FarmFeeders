import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/flush_bar.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Utils/custom_button.dart';
import '../controller/set_farm.dart';
import '../models/SetupFarmInfoModel/farm_info_model.dart';
import '../view_models/SetupFarmInfoAPI.dart';
import 'basic_subscription_plan.dart';

bool isSetFarmInfo = false;
// bool get isSetFarmInfo => isSetFarmInfo;

bool isSetLiveStockInfo = false;
// bool get isSetLiveStockInfo => isSetLiveStockInfo;

bool isSetFeedInfo = false;
// bool get isSetFeedInfo => _isSetFeedInfo;

class LetsSetUpYourFarm extends StatefulWidget {
  bool isInside, farm, feed, livestock;
  LetsSetUpYourFarm({
    super.key,
    required this.isInside,
    required this.farm,
    required this.feed,
    required this.livestock,
  });

  @override
  State<LetsSetUpYourFarm> createState() => _LetsSetUpYourFarmState();
}

class _LetsSetUpYourFarmState extends State<LetsSetUpYourFarm> {
  // TextEditingController phoneController = TextEditingController();
  // TextEditingController pincode = TextEditingController();

  SetFarm setFarm = Get.put(SetFarm());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    if (widget.isInside) {
      isSetFarmInfo = widget.farm;
      isSetLiveStockInfo = widget.livestock;
      isSetFeedInfo = widget.feed;
      setState(() {});
    }
    super.initState();
  }

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
                  //  if (!isSetFarmInfo) {
                  setFarm.isFarmInfoUpdate.value = false;
                  SetupFarmInfoApi().getFarmInfoApi().then((value) async {
                    setFarm.isFarmInfoUpdate.value = true;
                    setFarm.farmInfoModel = FarmInfoModel.fromJson(value.data);

                    var res = await Get.toNamed(RouteName.farmsInfo);
                    if (res == true) {
                      setState(() {});
                    }
                  });

                  //  }
                },
                set: isSetFarmInfo,
                imagePath: "assets/images/setupFarm1.png",
                title: "Farm Information",
                des: "Check Your Farm Details",
              ),
              sizedBoxHeight(25.h),
              cards(
                onTap: () async {
                  if (isSetFarmInfo) {
                    var res = await Get.toNamed(RouteName.liveStockInfoMain);
                    if (res == true) {
                      setState(() {});
                    }
                  } else {
                    commonFlushBar(context,
                        msg: "Please update Farm information");
                  }
                  // var res = await Get.toNamed(RouteName.liveStockInfoMain);
                },
                set: isSetLiveStockInfo,
                imagePath: "assets/images/setupFarm2.png",
                title: "Livestock Information",
                des: "Check Your Livestock Details",
              ),

              sizedBoxHeight(25.h),

              cards(
                onTap: () async {
                  if (isSetFarmInfo && isSetLiveStockInfo) {
                    var res = await Get.toNamed("/farmfeedtracker");
                    if (res == true) {
                      setState(() {});
                    }
                  } else {
                    commonFlushBar(context,
                        msg:
                            "Please update Farm information & Live stock information");
                  }
                  // var res = await Get.toNamed("/farmfeedtracker");

                  // Get.toNamed("/farmfeedtracker");
                },
                set: isSetFeedInfo,
                imagePath: "assets/images/setupFarm3.png",
                title: "Feed Information",
                des: "Check Your Feed Details",
              ),

              (isSetFarmInfo && isSetLiveStockInfo && isSetFeedInfo)
                  ? sizedBoxHeight(100.h)
                  : sizedBoxHeight(35.h),

              (isSetFarmInfo && isSetLiveStockInfo && isSetFeedInfo)
                  ? CustomButton(
                      text: "Procced To Subscription",
                      onTap: () {
                        Get.to(const BasicSubscriptionPlan());
                      })
                  : SizedBox()

              // GestureDetector(
              //     onTap: () {
              //       Get.to(SideMenu());
              //     },
              //     child: textGreen16W700("Skip & Procced to dashboard"))

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
                  color: set
                      ? AppColors.buttoncolour
                      :
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
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 19.w,
                        color: set ? AppColors.white : AppColors.transparent,
                      ),
                    ),
                    set
                        ? textWhite20W7000Mon(title)
                        : textBlack20W7000Mon(title),
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
}
