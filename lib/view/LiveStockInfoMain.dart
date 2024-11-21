// import 'dart:html';

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_dropdown.dart';
import 'package:farmfeeders/common/flush_bar.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/live_stock_info_contro.dart';
import 'package:farmfeeders/models/livestock_type_model.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:farmfeeders/view_models/SetupFarmInfoAPI.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/sized_box.dart';
import '../models/feed_Info_dropdown.dart';

class LiveStockInfoLive extends StatefulWidget {
  const LiveStockInfoLive({super.key});

  @override
  State<LiveStockInfoLive> createState() => _LiveStockInfoMainState();
}

ScrollController? controller;
ScrollController? _scrollviewcontroller;

class _LiveStockInfoMainState extends State<LiveStockInfoLive> {
  bool setDairy = false;
  bool setBeef = false;
  bool setSheep = false;
  bool setPigs = false;
  bool setPoultry = false;

  LiveStockInfoContro liveStockInfoController = Get.put(LiveStockInfoContro());
  LiveStockTypeModel liveStockTypeModel = LiveStockTypeModel();
  RxBool isLoading = false.obs;
  final tecNumber = TextEditingController();
  int? selectedAgeIndex;
  int? selectedBreedIndex;
  int filledCount = 0;

  FeedDropDownInfo? _feedDropdownData;
  List<Map<int, bool>> checkList = [];

  @override
  void initState() {
    isLoading.value = true;
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'LivestockInfo',
      screenClass: 'LiveStockInfoLive',
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SetupFarmInfoApi().getLivestockTypeApi().then((value) {
        liveStockTypeModel = LiveStockTypeModel.fromJson(value.data);
        for (var a in liveStockTypeModel.data!) {
          if (a.filled!) {
            filledCount += 1;
            getApiFeedDropdownData(a.id!.toString());
          }
        }
        isLoading.value = false;
      });
    });

    super.initState();
  }

  bool checkValue(List<Map<int, bool>> mapList, int key, bool value) {
    for (var map in mapList) {
      if (map.containsKey(key) && map[key] == value) {
        return true;
      }
    }
    return false;
  }

  getApiFeedDropdownData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var headers = {
        'Authorization': "Bearer $token",
      };
      var dio = Dio();
      log(ApiUrls.getFeedInfoDropdownData + id);
      var response = await dio.request(
        ApiUrls.getFeedInfoDropdownData + id,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        _feedDropdownData = FeedDropDownInfo.fromJson(response.data);

        checkList.add({
          int.parse(id): _feedDropdownData!.data.feed != null ? true : false
        });
        log(checkList.toString());
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  buildprofilelogoutdialog(context, id) {
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
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.delete,
                    size: 50,
                    color: AppColors.redFA5658,
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
                        await FirebaseAnalytics.instance
                            .logEvent(name: 'delete_livestock', parameters: {
                          'livestock_id': id.toString(),
                        });
                        Get.back();
                        isLoading.value = true;
                        SetupFarmInfoApi()
                            .deleteFeedLivestockApi(id.toString())
                            .then((value) {
                          filledCount = 0;
                          SetupFarmInfoApi()
                              .getLivestockTypeApi()
                              .then((value) {
                            liveStockTypeModel =
                                LiveStockTypeModel.fromJson(value.data);
                            checkList.clear();
                            for (var a in liveStockTypeModel.data!) {
                              if (a.filled!) {
                                filledCount += 1;
                                getApiFeedDropdownData(a.id!.toString());
                              }
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

  restrictCancelDialog(context) {
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
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.warning_rounded,
                    size: 80,
                    color: Colors.redAccent,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "You need to add alteast one other feed data to delete this one",
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 180.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
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
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 16.0.w,
          right: 16.w,
          bottom: 15, 
        ),
        child: CustomButton(
            text: "Update",
            onTap: () {
              bool isSetLiveStockInfoV = false;

              for (var a in liveStockTypeModel.data!) {
                if (a.filled == true) {
                  isSetLiveStockInfoV = true;
                  break;
                }
              }

              if (!isSetLiveStockInfoV) {
                utils.showToast("Add alteast one livestock data");
              } else {
                FirebaseAnalytics.instance
                    .logEvent(name: 'update_livestock_info', parameters: {
                  'total_livestock_types': filledCount.toString(),
                });
                isSetLiveStockInfo = true;
                Get.back(result: true);
              }
            }),
      ),
      appBar: AppBar(
        title: customAppBar(text: "Livestock Information"),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        titleSpacing: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        // reverse: true,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    children: [
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      SvgPicture.asset("assets/images/Mask Group 26.svg"),
                      SizedBox(
                        height: 15.h,
                      ),
                      isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.buttoncolour,
                              ),
                            )
                          : SizedBox(
                              height: Get.height / 2,
                              child: GridView.builder(
                                  itemCount: liveStockTypeModel.data!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1 / 1.2,
                                    crossAxisCount:
                                        2, // number of items in each row
                                    mainAxisSpacing:
                                        15.0, // spacing between rows
                                    crossAxisSpacing:
                                        10.0, // spacing between columns
                                  ),
                                  itemBuilder: (ctx, index) {
                                    return InkWell(
                                      onTap: () async {
                                        // liveStockInfoController.getApi();
                                        await liveStockInfoController
                                            .getApiForLiveStockData(
                                                selectedNum:
                                                    (index + 1).toString())
                                            .then((value) {
                                          if (value == "Access Denied") {
                                            // Get.back();
                                            commonFlushBar(context,
                                                msg: "Access Denied");
                                          } else {
                                            if (liveStockInfoController
                                                    .liveStockData!
                                                    .data
                                                    .livestock !=
                                                null) {
                                              for (var i
                                                  in liveStockInfoController
                                                      .liveStockData!
                                                      .data
                                                      .ageList) {
                                                if (i.id ==
                                                    liveStockInfoController
                                                        .liveStockData!
                                                        .data
                                                        .livestock!
                                                        .livestockAgeXid) {
                                                  liveStockInfoController
                                                      .updateSelectedAge(
                                                          i.name);
                                                  selectedAgeIndex = i.id;
                                                }
                                              }

                                              for (var i
                                                  in liveStockInfoController
                                                      .liveStockData!
                                                      .data
                                                      .breedList) {
                                                if (i.id ==
                                                    liveStockInfoController
                                                        .liveStockData!
                                                        .data
                                                        .livestock!
                                                        .livestockBreedXid) {
                                                  liveStockInfoController
                                                      .updateSelectedBreed(
                                                          i.name);
                                                  selectedBreedIndex = i.id;
                                                }
                                              }

                                              tecNumber.text =
                                                  liveStockInfoController
                                                      .liveStockData!
                                                      .data
                                                      .livestock!
                                                      .number
                                                      .toString();
                                            } else {
                                              selectedBreedIndex = null;
                                              selectedAgeIndex = null;
                                              tecNumber.clear();
                                            }

                                            buildAddDataDailog(
                                                index: index + 1,
                                                titleText: liveStockTypeModel
                                                    .data![index].name!);
                                          }
                                        });
                                        // addDataDialog(1);
                                        // buildAddDataDailog();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: liveStockTypeModel
                                                    .data![index].filled!
                                                ? 2.5
                                                : 0.5,
                                            color: const Color(0xFF0E5F02),
                                            // color: AppColors.white
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        // height: 250.h,
                                        // height: 250.h,
                                        width: 170.w,
                                        child: Column(
                                          // mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const Spacer(),
                                            Row(
                                              children: [
                                                filledCount == 1
                                                    ? const SizedBox()
                                                    : InkWell(
                                                        onTap: () {
                                                          if (checkValue(
                                                              checkList,
                                                              liveStockTypeModel
                                                                  .data![index]
                                                                  .userLivestockLink![
                                                                      0]
                                                                  .livestockTypeXid!,
                                                              false)) {
                                                            buildprofilelogoutdialog(
                                                                context,
                                                                liveStockTypeModel
                                                                    .data![
                                                                        index]
                                                                    .userLivestockLink![
                                                                        0]
                                                                    .id);
                                                          } else {
                                                            int trueCount = checkList.fold(
                                                                0,
                                                                (count, map) =>
                                                                    count +
                                                                    (map.containsValue(
                                                                            true)
                                                                        ? 1
                                                                        : 0));
                                                            if (trueCount > 1) {
                                                              buildprofilelogoutdialog(
                                                                  context,
                                                                  liveStockTypeModel
                                                                      .data![
                                                                          index]
                                                                      .userLivestockLink![
                                                                          0]
                                                                      .id);
                                                            } else {
                                                              restrictCancelDialog(
                                                                  context);
                                                            }
                                                          }
                                                        },
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5.h,
                                                                    left: 5.h),
                                                            child: Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              size: 19.w,
                                                              color: liveStockTypeModel
                                                                      .data![
                                                                          index]
                                                                      .filled!
                                                                  ? AppColors
                                                                      .redFA5658
                                                                  : AppColors
                                                                      .transparent,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                const Spacer(),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.h, right: 5.h),
                                                    child: Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                      size: 19.w,
                                                      color: liveStockTypeModel
                                                              .data![index]
                                                              .filled!
                                                          ? AppColors
                                                              .buttoncolour
                                                          : AppColors
                                                              .transparent,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            CircleAvatar(
                                              radius: 55,
                                              backgroundColor:
                                                  const Color(0xFFF1F1F1),
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${ApiUrls.baseImageUrl}${liveStockTypeModel.data![index].smallImageUrl}"),
                                            ),
                                            const Spacer(),
                                            Text(
                                              liveStockTypeModel
                                                  .data![index].name!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  buildAddDataDailog({required int index, required String titleText}) {
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                  contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                    side: const BorderSide(color: Colors.white),
                  ),
                  content: GetBuilder<LiveStockInfoContro>(builder: (builder) {
                    return liveStockInfoController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.buttoncolour,
                          ))
                        : Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textBlack25W600Mon(titleText),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: AppColors.greyF1F1F1,
                                        radius: 20,
                                        child: Center(
                                          child: Text(
                                            "x",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 26,
                                                color: Color(0XFF0E5F02)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Age"),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 315,
                                      child: DropdownBtn(
                                        hint: "Please Select Age",
                                        // items: ,
                                        items: liveStockInfoController
                                            .liveStockData!.data.ageList
                                            .map((e) => DropdownMenuItem(
                                                  value: e.name,
                                                  onTap: () {
                                                    liveStockInfoController
                                                        .updateSelectedAge(
                                                            e.name);
                                                    selectedAgeIndex = e.id;
                                                  },
                                                  child: Text(
                                                    e.name,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF4D4D4D),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value:
                                            liveStockInfoController.selectedAge,
                                        // liveStockInfoController.liveStockData!.data.ageList
                                        // [
                                        //   "<2 Yrs",
                                        //   "> & <5 yrs",
                                        //   ">5 Yrs",
                                        // ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Breed"),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 315,
                                      child: DropdownBtn(
                                        hint: "Please Select Breed",
                                        items: liveStockInfoController
                                            .liveStockData!.data.breedList
                                            .map((e) => DropdownMenuItem(
                                                  value: e.name,
                                                  onTap: () {
                                                    // selectedBreed = e.name;
                                                    liveStockInfoController
                                                        .updateSelectedBreed(
                                                            e.name);
                                                    selectedBreedIndex = e.id;
                                                  },
                                                  child: Text(
                                                    e.name,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF4D4D4D),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: liveStockInfoController
                                            .selectedBreed,

                                        // items: [
                                        //   "Irish Angus",
                                        //   "Irish Dexter",
                                        //   "irish Holstein-Friesian",
                                        //   "irish Holstein-Friesian1",
                                        //   "irish Holstein-Friesian2",
                                        // ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Number"),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      width: 315,
                                      child: CustomTextFormField(
                                        textEditingController: tecNumber,
                                        texttype: TextInputType.number,
                                        hintText: "Enter number",
                                        validatorText: "validatorText",
                                        // validator: ,
                                        validator: (value) {
                                          if (value.isEmpty || value == null) {
                                            return 'Please enter number';
                                          }
                                          // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          //     .hasMatch(value)) {
                                          //   return 'Please enter a valid email address';
                                          // }
                                          // v1 = true;
                                          return null;
                                        },
                                        inputFormatters: <TextInputFormatter>[
                                          // for below version 2 use this
                                          // FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          // for version 2 and greater youcan also use this
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomButton(
                                  text: "Save",
                                  onTap: () async {
                                    if (selectedAgeIndex != null &&
                                        selectedBreedIndex != null) {
                                      final FormState? form =
                                          formKey.currentState;
                                      if (form != null && form.validate()) {
                                        Utils.loader();
                                        await liveStockInfoController
                                            .setApiLiveStockData(
                                                liveStockType: index.toString(),
                                                liveStockAge:
                                                    selectedAgeIndex.toString(),
                                                liveStockBreed:
                                                    selectedBreedIndex
                                                        .toString(),
                                                count: tecNumber.text)
                                            .then((value) {
                                          if (value == "success") {
                                            FirebaseAnalytics.instance.logEvent(
                                                name: 'add_livestock',
                                                parameters: {
                                                  'livestock_type': titleText,
                                                  'livestock_age':
                                                      selectedAgeIndex
                                                          .toString(),
                                                  'livestock_breed':
                                                      selectedBreedIndex
                                                          .toString(),
                                                  'livestock_count':
                                                      tecNumber.text,
                                                });
                                            SetupFarmInfoApi()
                                                .getLivestockTypeApi()
                                                .then((value) {
                                              filledCount = 0;
                                              isLoading.value = true;
                                              liveStockTypeModel =
                                                  LiveStockTypeModel.fromJson(
                                                      value.data);
                                              isLoading.value = false;
                                              Get.back();
                                              Get.back();
                                              setLiveStockFor(index);
                                              checkList.clear();
                                              for (var a
                                                  in liveStockTypeModel.data!) {
                                                if (a.filled!) {
                                                  filledCount += 1;
                                                  getApiFeedDropdownData(
                                                      a.id!.toString());
                                                }
                                              }
                                            });
                                          } else if (value == "Access Denied") {
                                            Get.back();
                                            commonFlushBar(context,
                                                msg: "Access Denied");
                                          }
                                        });
                                      }
                                    } else {
                                      // com
                                      // commonFlushBar(context,);
                                      commonFlushBar(context,
                                          msg: "Please select age and breed");
                                      // Get.snackbar("Error", "Please select age and breed");
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                  })),
            ],
          ),
        ],
      ),
    );
  }

  setLiveStockFor(int index) {
    print(index);
    switch (index) {
      case 1:
        {
          setState(() {
            setDairy = true;
          });
        }
        break;

      case 2:
        {
          setState(() {
            setBeef = true;
          });
        }
        break;

      case 3:
        {
          setState(() {
            setSheep = true;
          });
        }
        break;

      case 4:
        {
          setState(() {
            setPigs = true;
          });
        }
        break;

      case 5:
        {
          setState(() {
            setPoultry = true;
          });
        }
        break;

      default:
        {}
    }
  }
}
