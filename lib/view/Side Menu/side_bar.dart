import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/api_urls.dart';
import '../../models/ProfileModel/profile_info_model.dart';
import '../../view_models/ProfileAPI.dart';
import '../Profile/personalinfo.dart';
import 'NavigateTo pages/subscription_plan.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    // required this.press, required this.currentIndex
  });

  @override
  State<SideBar> createState() => _SideBarState();

  // final VoidCallback press;
  // final int currentIndex;
}

class _SideBarState extends State<SideBar> {
  // final ProfileImageController editProfileImage =
  //     Get.put(ProfileImageController());

  ProfileController profileController = Get.put(ProfileController());

  List sideBarData = [
    {
      "icon": Image.asset(
        "assets/images/manageUser.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Manage User",
      "route": "/manageuser"
    },
    {
      "icon": Image.asset(
        "assets/images/connect.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Connect With Experts",
      "route": "/connectexperts"
    },
    {
      "icon": Image.asset(
        "assets/images/training.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Training",
      "route": "/trainingmain"
    },
    {
      "icon": Image.asset(
        "assets/images/news.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "News & Articles",
      "route": "/newsandarticlemain"
    },
    {
      "icon": Image.asset(
        "assets/images/faq.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "FAQ",
      "route": "/faq"
    },
    {
      "icon": Image.asset(
        "assets/images/feedback.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Feedback",
      "route": "/feedBack"
    },
    {
      "icon": Image.asset(
        "assets/images/contactus.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Contact Us",
      "route": "/contactus"
    },
    {
      "icon": Image.asset(
        "assets/images/connection_code.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Connection Code",
      "route": "/connect"
    },
    {
      "icon": Image.asset(
        "assets/images/subscription@2x.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Subscription Plan",
      "route": "/SubscriptionPlan"
    },
  ];

  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());
  RxBool isLoading = false.obs;
  DashboardController dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    checkSubUserPermission();
    isLoading.value = true;
    ProfileAPI().getProfileInfo().then((value) {
      profileController.profileInfoModel.value =
          ProfileInfoModel.fromJson(value.data);
      isLoading.value = false;
    });

    super.initState();
  }

  List<int> permissionList = [];
  Future<void> checkSubUserPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mList = (prefs.getStringList('permissionList') ?? []);
    permissionList = mList.map((i) => int.parse(i)).toList();

    if (permissionList.isNotEmpty) {
      sideBarData.removeAt(0);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 300.w,
          // height: double.infinity,
          decoration: const BoxDecoration(color: Color(0xff0E5F02)),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 45.w, 10.h),
              child: Column(
                children: [
                  sizedBoxHeight(80.h),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 65.w,
                              width: 65.w,
                              child: Obx(
                                () => isLoading.value
                                    ? const SizedBox()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: editProfileImage
                                                    .profilePicPath.value !=
                                                ''
                                            ? Image(
                                                image: FileImage(File(
                                                    editProfileImage
                                                        .profilePicPath.value)),
                                                fit: BoxFit.cover,
                                                width: 50.w,
                                                height: 50.h,
                                              )
                                            : profileController
                                                    .profileInfoModel
                                                    .value
                                                    .data!
                                                    .profilePhoto!
                                                    .isEmpty
                                                ? Image.asset(
                                                    "assets/images/profile.png")
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}"),
                                      ),
                              ),
                            ),
                            // Positioned(
                            //   bottom: 5.h,
                            //   right: 5,
                            //   child: Icon(
                            //     Icons.add_a_photo_outlined,
                            //     color: const Color(0xff0E5F02),
                            //     size: 15.h,
                            //   ),
                            // ),
                          ],
                        ),
                        sizedBoxWidth(15.w),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileController
                                    .profileInfoModel.value.data!.userName!,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              sizedBoxHeight(4.h),
                              Text(
                                profileController
                                    .profileInfoModel.value.data!.phoneNumber!,
                                style: TextStyle(fontSize: 16.sp),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  permissionList.isNotEmpty
                      ? sizedBoxHeight(30.h)
                      : sizedBoxHeight(60.h),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sideBarData.length,
                      itemBuilder: (_, index) {
                        return SideBarTile(
                          // icon: sideBarData[index]["icon"],

                          icon: sideBarData[index]["icon"],

                          text: sideBarData[index]["text"],
                          onTap: () {
                            // if (index == 9) {
                            //   // logoutDailog(context);
                            //   // buildprofilelogoutdialog(context);
                            // } else
                            // {
                            if (index == 8) {
                              Get.to(() => SubscriptionPlan(
                                    fromScreen: "froMSideBar",
                                  ));
                            } else {
                              // dashboardController.isSideMenuClosed.value =
                              //     false;
                              Get.toNamed(sideBarData[index]["route"]);
                            }

                            // }
                            // Get.toNamed(sideBarData[index]["route"]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void navigateTo(int index, BuildContext context) {
  switch (index) {
    case 6:
      {
        null;
      }
      break;

    default:
      {
        null;
      }
  }
}

class SideBarTile extends StatelessWidget {
  Widget icon;
  String text;
  void Function()? onTap;

  SideBarTile({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: 22.w,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
