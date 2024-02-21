import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:farmfeeders/controller/sub_user_controller.dart';
import 'package:farmfeeders/view_models/SubUserApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Utils/colors.dart';
import '../../../models/subUserModel.dart';

class manageUser extends StatefulWidget {
  const manageUser({super.key});

  @override
  State<manageUser> createState() => _manageUserState();
}

class _manageUserState extends State<manageUser> {
  RxBool isLoading = true.obs;
  List<SubUserData> dataList = [];
  int maxValue = 5;
  @override
  void initState() {
    SubuserApi().getsubUserList().then((value) {
      SubUserModel subUserModel = SubUserModel.fromJson(value.data);
      for (var a in subUserModel.data!) {
        dataList.add(a);
      }
      isLoading.value = false;
    });
    super.initState();
  }

  SubUserController subUserController = Get.put(SubUserController());

  buildprofilelogoutdialog(
    context,
    String id,
  ) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/delete.png",
                    width: 40.w,
                    height: 50.h,
                    color: AppColors.buttoncolour,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to Delete?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        dataList.clear();
                        SubuserApi().deleteSubUser(id).then((value) {
                          Get.back();
                          isLoading.value = true;
                          SubuserApi().getsubUserList().then((value) {
                            SubUserModel subUserModel =
                                SubUserModel.fromJson(value.data);
                            for (var a in subUserModel.data!) {
                              dataList.add(a);
                            }
                            isLoading.value = false;
                          });
                        });
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: customAppBar(text: "Manage Users"),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Can only add $maxValue users",
                    style: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontFamily: 'Poppins',
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //    Text(email.text)

              customButton(
                text: "Add Sub Users",
                onTap: () async {
                  if (dataList.length < maxValue) {
                    var res = await Get.toNamed("/addsubuser",
                        arguments: {"isEdit": false});
                    if (res == true) {
                      dataList.clear();
                      isLoading.value = true;
                      SubuserApi().getsubUserList().then((value) {
                        SubUserModel subUserModel =
                            SubUserModel.fromJson(value.data);
                        for (var a in subUserModel.data!) {
                          dataList.add(a);
                        }
                        isLoading.value = false;
                      });
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                            content: Text(
                                "You can't add more than $maxValue users")));
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(
                () => isLoading.value
                    ? const CircularProgressIndicator(
                        color: AppColors.buttoncolour,
                      )
                    : dataList.isNotEmpty
                        ? SizedBox(
                            height: Get.height / 1.42,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: dataList.length,
                              itemBuilder: ((context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFFF1F1F1),
                                      ),
                                      width: double.infinity,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Full Name        : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF4D4D4D)),
                                                    ),
                                                    Text(
                                                      dataList[index].name!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Date Of Birth : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF4D4D4D)),
                                                    ),
                                                    Text(
                                                      dataList[index].dob!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Phone               : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF4D4D4D)),
                                                    ),
                                                    Text(
                                                      dataList[index]
                                                          .phoneNumber!,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Email                 : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF4D4D4D)),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        dataList[index].email!,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 18,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "Address           : ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(
                                                              0xFF4D4D4D)),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width / 2.1,
                                                      child: Text(
                                                        dataList[index]
                                                            .address!,
                                                        maxLines: 8,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: PopupMenuButton(
                                            icon: const Icon(Icons.more_vert),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                  onTap: () async {
                                                    subUserController
                                                            .subUserData =
                                                        dataList[index];
                                                    var res = await Get.toNamed(
                                                        "/addsubuser",
                                                        arguments: {
                                                          "isEdit": true
                                                        });
                                                    if (res == true) {
                                                      dataList.clear();
                                                      isLoading.value = true;
                                                      SubuserApi()
                                                          .getsubUserList()
                                                          .then((value) {
                                                        SubUserModel
                                                            subUserModel =
                                                            SubUserModel
                                                                .fromJson(
                                                                    value.data);
                                                        for (var a
                                                            in subUserModel
                                                                .data!) {
                                                          dataList.add(a);
                                                        }
                                                        isLoading.value = false;
                                                      });
                                                    }
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons.edit_outlined),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Edit"),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  onTap: () {
                                                    buildprofilelogoutdialog(
                                                        context,
                                                        dataList[index]
                                                            .id
                                                            .toString());
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(Icons
                                                          .delete_outlined),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Delete"),
                                                    ],
                                                  ),
                                                )
                                              ];
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ),
                          )
                        : const Text("NO SUB USER FOUND"),
              ),

              //  sizedBoxHeight(58.h)
            ],
          ),
        ),
      ),
    );
  }
}
