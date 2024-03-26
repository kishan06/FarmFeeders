import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_dropdown.dart';
import 'package:farmfeeders/common/flush_bar.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/farm_feed_controller.dart';
import 'package:farmfeeders/models/SetupFarmInfoModel/feed_livestock_model.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../view_models/SetupFarmInfoAPI.dart';

class Farmfeedtracker extends StatefulWidget {
  Farmfeedtracker({
    required this.isInside,
    required this.index,
    super.key,
  });
  bool isInside;
  int index;

  @override
  State<Farmfeedtracker> createState() => _FarmfeedtrackerState();
}

class _FarmfeedtrackerState extends State<Farmfeedtracker> {
  bool notCollapsed = true;

  FeedInfoContro feedInfoController = Get.put(FeedInfoContro());
  FeedLivestockModel feedLivestockModel = FeedLivestockModel();
  RxBool isLoading = false.obs;
  @override
  void initState() {
    super.initState();
    feedInfoController.getApiFeedDropdownData("1");
    isLoading.value = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      feedInfoController.expansionController.clear();
      SetupFarmInfoApi().getFeedLivestockApi().then((value) {
        feedLivestockModel = FeedLivestockModel.fromJson(value.data);

        feedInfoController.expansionController =
            List.filled(5, ExpansionTileController());
        isLoading.value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: CustomButton(
              text: "Update",
              onTap: () async {
                List<bool> values =
                    List.filled(feedLivestockModel.data!.length, true);

                for (int i = 0; i < feedLivestockModel.data!.length; i++) {
                  await feedInfoController
                      .getApiFeedDropdownData(
                          (feedLivestockModel.data![i].id!).toString())
                      .then((value) {
                    if (feedInfoController.feedDropdownData!.data.feed ==
                        null) {
                      values[i] = false;
                      utils.showToast("Please Update All Feeds");
                      // return;
                    }
                  });
                }
                if (values.every((value) => value)) {
                  isSetFeedInfo = true;

                  Get.back(result: true);
                }

                // isSetLiveStockInfo = true;
                // Get.back(result: true);
              }),
        ),
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      radius: 20.h,
                      backgroundColor: const Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.h),
                  Text(
                    "Farm Feed Tracker",
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0XFF141414)),
                  )
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    child: GetBuilder<FeedInfoContro>(builder: (builder) {
                      return feedInfoController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.buttoncolour,
                            ))
                          :
                          // feedInfoController.feedDropdownData == null
                          // ?
                          // :
                          Obx(
                              () => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                          color: AppColors.buttoncolour,
                                        ))
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              feedLivestockModel.data!.length,
                                          itemBuilder: (context, index) {
                                            // final liveStockData = feedInfoController
                                            return Column(
                                              children: [
                                                FeedContainer(
                                                  titleText: feedLivestockModel
                                                      .data![index].name!,
                                                  imagePath: feedLivestockModel
                                                      .data![index]
                                                      .smallImageUrl!,
                                                  index: index,
                                                  updated: false,
                                                  feedId: feedLivestockModel
                                                      .data![index].id!,
                                                  isInside: widget.isInside,
                                                  selectedFeedId: widget.index,
                                                ),
                                                sizedBoxHeight(15.h),
                                              ],
                                            );
                                          },
                                        ),
                                ],
                              ),
                            );
                    })))
          ],
        ),
      ),
    );
  }
}

class FeedContainer extends StatefulWidget {
  String titleText;
  String imagePath;
  int index;
  bool updated;
  int feedId;
  int selectedFeedId;
  bool isInside;

  FeedContainer({
    super.key,
    required this.titleText,
    required this.imagePath,
    required this.index,
    required this.updated,
    required this.feedId,
    required this.selectedFeedId,
    required this.isInside,
  });

  @override
  State<FeedContainer> createState() => _FeedContainerState();
}

class _FeedContainerState extends State<FeedContainer> {
  final GlobalKey<FormState> _formFeedContainer = GlobalKey<FormState>();

  FeedInfoContro feedInfoController = Get.put(FeedInfoContro());

  bool buttonPressed = false;
  RxBool isLoading = false.obs;

  final tecCurrentFeed = TextEditingController();
  final tecQuantity = TextEditingController();
  final tecMin = TextEditingController();
  final tecMax = TextEditingController();

  String? selectedFeedType;
  int? selectedFeedTypeIndex;

  String? selectedFrequency;
  int? selectedFrequencyIndex;
  bool isExpanded = false;

  @override
  void initState() {
    if (widget.isInside) {
      if (widget.selectedFeedId == widget.feedId) {
        isExpanded = true;
        Future.delayed(const Duration(milliseconds: 1), () async {
          isLoading.value = true;
          await feedInfoController
              .getApiFeedDropdownData(widget.feedId.toString())
              .then((value) {
            if (feedInfoController.feedDropdownData!.data.feed != null) {
              for (var i
                  in feedInfoController.feedDropdownData!.data.feedType) {
                if (i.id ==
                    feedInfoController
                        .feedDropdownData!.data.feed!.feedTypeXid) {
                  selectedFeedType = i.name;
                  selectedFeedTypeIndex = i.id;
                }
              }

              for (var i
                  in feedInfoController.feedDropdownData!.data.feedFrequency) {
                if (i.id ==
                    feedInfoController
                        .feedDropdownData!.data.feed!.feedFrequencyXid) {
                  selectedFrequency = i.name;
                  selectedFrequencyIndex = i.id;
                }
              }

              tecCurrentFeed.text = feedInfoController
                  .feedDropdownData!.data.feed!.currentFeedAvailable!
                  .toString();
              tecQuantity.text = feedInfoController
                  .feedDropdownData!.data.feed!.qtyPerSeed!
                  .toString();
              tecMin.text = feedInfoController
                  .feedDropdownData!.data.feed!.minBinCapacity!
                  .toString();
              tecMax.text = feedInfoController
                  .feedDropdownData!.data.feed!.maxBinCapacity!
                  .toString();
            } else {
              selectedFrequencyIndex = null;
              selectedFeedTypeIndex = null;
              selectedFeedType = null;
              selectedFrequency = null;
              tecCurrentFeed.clear();
              tecMax.clear();
              tecMin.clear();
              tecQuantity.clear();
            }
            isLoading.value = false;
          });
        });
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: widget.updated
              ? Border.all(color: AppColors.buttoncolour, width: 1.5.w)
              : isExpanded
                  ? Border.all(color: const Color(0xffCCCCCC))
                  : null,
          color: isExpanded ? AppColors.white : AppColors.greyF1F1F1,
          borderRadius: BorderRadius.circular(10.r)),
      child: ExpansionTile(
          //  controller: feedInfoController.expansionController[widget.index],
          childrenPadding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (bool expanding) async {
            if (expanding) {
              isLoading.value = true;
              await feedInfoController
                  .getApiFeedDropdownData(widget.feedId.toString())
                  .then((value) {
                if (feedInfoController.feedDropdownData!.data.feed != null) {
                  for (var i
                      in feedInfoController.feedDropdownData!.data.feedType) {
                    if (i.id ==
                        feedInfoController
                            .feedDropdownData!.data.feed!.feedTypeXid) {
                      selectedFeedType = i.name;
                      selectedFeedTypeIndex = i.id;
                    }
                  }

                  for (var i in feedInfoController
                      .feedDropdownData!.data.feedFrequency) {
                    if (i.id ==
                        feedInfoController
                            .feedDropdownData!.data.feed!.feedFrequencyXid) {
                      selectedFrequency = i.name;
                      selectedFrequencyIndex = i.id;
                    }
                  }

                  tecCurrentFeed.text = feedInfoController
                      .feedDropdownData!.data.feed!.currentFeedAvailable!
                      .toString();
                  tecQuantity.text = feedInfoController
                      .feedDropdownData!.data.feed!.qtyPerSeed!
                      .toString();
                  tecMin.text = feedInfoController
                      .feedDropdownData!.data.feed!.minBinCapacity!
                      .toString();
                  tecMax.text = feedInfoController
                      .feedDropdownData!.data.feed!.maxBinCapacity!
                      .toString();
                } else {
                  selectedFrequencyIndex = null;
                  selectedFeedTypeIndex = null;
                  selectedFeedType = null;
                  selectedFrequency = null;
                  tecCurrentFeed.clear();
                  tecMax.clear();
                  tecMin.clear();
                  tecQuantity.clear();
                }
                isLoading.value = false;
              });
            }
            setState(() {
              isExpanded = expanding;
              // for (int i = 0; i < feedInfoController.isOpened.length; i++) {
              //   if (i != widget.index) {
              //     feedInfoController.isOpened[i] = false;
              //   } else {
              //     feedInfoController.isOpened[i] = true;
              //   }
              //  }
            });
          },
          trailing: Icon(
            isExpanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            size: 25.sp,
            color: isExpanded ? Colors.black : Colors.black,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: (ApiUrls.baseImageUrl + widget.imagePath),
                width: 59.w,
                // width: 100.w,

                height: 42.h,
                // height: 100.h,
              ),
              sizedBoxWidth(19.w),
              Text(
                widget.titleText,
                style: TextStyle(
                    color: AppColors.black,
                    fontFamily: "Poppins",
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: <Widget>[
            Obx(
              () => Form(
                key: _formFeedContainer,
                child: isLoading.value
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttoncolour,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Text(
                            "Current feed on farm?",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxWidth(6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Feedtextformfield(
                                textEditingController: tecCurrentFeed,
                                hintText: "",
                                texttype: TextInputType.number,
                                validatorText: "Please Enter Feed",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Feed";
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,3}'))
                                ],
                                // inputFormatters: ,
                              ),
                              // sizedBoxWidth(3.w),
                              const Spacer(),
                              Container(
                                height: 50.h,
                                width: 62.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    color: AppColors.buttoncolour),
                                child: Center(
                                  child: Text(
                                    "Kgs",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBoxHeight(14.h),
                          Text(
                            "Type of feed ?",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxHeight(6.h),

                          DropdownBtn(
                            hint: "Please Select feed type",
                            // items: ,
                            items: feedInfoController
                                .feedDropdownData!.data.feedType
                                .map((e) => DropdownMenuItem(
                                      value: e.name,
                                      onTap: () {
                                        setState(() {
                                          selectedFeedType = e.name;
                                          selectedFeedTypeIndex = e.id;
                                        });
                                      },
                                      child: Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4D4D4D),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedFeedType,
                          ),

                          sizedBoxHeight(30.h),
                          Text(
                            "Feed usage",
                            style: TextStyle(
                                color: const Color(0XFF0E5F02),
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxHeight(14.h),
                          Text(
                            "Frequency",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxHeight(6.h),

                          DropdownBtn(
                            hint: "Please Select frequency",
                            // items: ,
                            items: feedInfoController
                                .feedDropdownData!.data.feedFrequency
                                .map((e) => DropdownMenuItem(
                                      value: e.name,
                                      onTap: () {
                                        setState(() {
                                          selectedFrequency = e.name;
                                          selectedFrequencyIndex = e.id;
                                        });
                                        // selectedBreed = e.name;
                                        // liveStockInfoController
                                        //     .updateSelectedBreed(e.name);
                                        // selectedBreedIndex = e.id;
                                      },
                                      child: Text(
                                        e.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4D4D4D),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedFrequency,
                            // liveStockInfoController.liveStockData!.data.ageList
                            // [
                            //   "<2 Yrs",
                            //   "> & <5 yrs",
                            //   ">5 Yrs",
                            // ],
                          ),

                          // SizedBox(
                          //   width: 315.w,
                          //   height: 50.h,
                          //   child: const FarmfeedDropdownBtn(
                          //       hint: "select frequency",
                          //       items: [
                          //         "1 Times a day",
                          //         "2 Times a day",
                          //         "3 Times a day",
                          //       ]),
                          // ),
                          sizedBoxHeight(14.h),
                          Text(
                            "Quantity Per Feed",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxHeight(6.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Feedtextformfield(
                                textEditingController: tecQuantity,
                                hintText: "",
                                validatorText: "Please Enter Quantity",
                                texttype: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Quantity";
                                  }
                                  return null;
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,3}'))
                                ],
                              ),
                              // sizedBoxWidth(3.w),
                              const Spacer(),
                              Container(
                                height: 50.h,
                                width: 62.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.h),
                                    color: AppColors.buttoncolour),
                                child: Center(
                                  child: Text(
                                    "Kgs",
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizedBoxHeight(14.h),
                          Text(
                            "Bin Capacity",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxHeight(6.h),
                          Container(
                            height: 130.h,
                            // width: 315.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: const Color(0xFFF1F1F1),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 8,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Min",
                                        style: TextStyle(
                                            color: const Color(0XFF4D4D4D),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      sizedBoxWidth(10.w),
                                      SizedBox(
                                        width: 200.w,
                                        // height: 46.h,
                                        child: TextFormField(
                                          controller: tecMin,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                          ),
                                          cursorColor: const Color(0xFF3B3F43),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                              errorStyle:
                                                  TextStyle(fontSize: 14.sp),
                                              isCollapsed: true,
                                              suffixIconConstraints:
                                                  const BoxConstraints(),
                                              contentPadding: EdgeInsets.only(
                                                  left: 17.w,
                                                  right: 17.w,
                                                  top: 15.h,
                                                  bottom: 10.h),
                                              filled: true,
                                              fillColor:
                                                  const Color(0XFFFFFFFF),
                                              hintStyle: TextStyle(
                                                  color:
                                                      const Color(0xFF4D4D4D),
                                                  fontSize: 18.sp,
                                                  fontFamily: "Poppins"),
                                              // hintText: "     / Kgs",
                                              suffixText: "/Kgs"),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              // return "Enter Min";
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Max",
                                        style: TextStyle(
                                            color: const Color(0XFF4D4D4D),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      sizedBoxWidth(6.w),
                                      SizedBox(
                                        width: 200.w,
                                        // height: 46.h,
                                        child: TextFormField(
                                          controller: tecMax,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                          ),
                                          cursorColor: const Color(0xFF3B3F43),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          decoration: InputDecoration(
                                              errorStyle:
                                                  TextStyle(fontSize: 14.sp),
                                              isCollapsed: true,
                                              suffixIconConstraints:
                                                  const BoxConstraints(),
                                              contentPadding: EdgeInsets.only(
                                                  left: 17.w,
                                                  right: 17.w,
                                                  top: 15.h,
                                                  bottom: 10.h),
                                              filled: true,
                                              fillColor:
                                                  const Color(0XFFFFFFFF),
                                              hintStyle: TextStyle(
                                                  color:
                                                      const Color(0xFF4D4D4D),
                                                  fontSize: 18.sp,
                                                  fontFamily: "Poppins"),
                                              // hintText: "     / Kgs",
                                              suffixText: "/Kgs"),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              // return "Enter Max";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          sizedBoxHeight(24.h),
                          InkWell(
                            onTap: () async {
                              final isValid =
                                  _formFeedContainer.currentState?.validate();
                              if (isValid!) {
                                if (double.tryParse(tecMin.text) != null &&
                                    double.tryParse(tecMax.text) != null) {
                                  double minValue = double.parse(tecMin.text);
                                  double maxValue = double.parse(tecMax.text);
                                  double feedValue =
                                      double.parse(tecCurrentFeed.text);
                                  if (minValue > maxValue) {
                                    Flushbar(
                                      message:
                                          "Min value cannot be greater than Max value",
                                      duration: const Duration(seconds: 3),
                                    ).show(context);
                                  } else if (feedValue > maxValue) {
                                    Flushbar(
                                      message:
                                          "Current feed value cannot be greater than Max value",
                                      duration: const Duration(seconds: 3),
                                    ).show(context);
                                  } else if ((selectedFeedTypeIndex == null) ||
                                      (selectedFrequencyIndex == null)) {
                                    Flushbar(
                                      message: "Please fill all fields",
                                      duration: const Duration(seconds: 3),
                                    ).show(context);
                                  } else {
                                    Utils.loader();
                                    final resp = await feedInfoController
                                        .setApiFarmFeed(map: {
                                      'livestock_type':
                                          widget.feedId.toString(),
                                      'current_feed': tecCurrentFeed.text,
                                      'feed_type':
                                          selectedFeedTypeIndex.toString(),
                                      'feed_frequency':
                                          selectedFrequencyIndex.toString(),
                                      'qty_per_seed': tecQuantity.text,
                                      'min_capacity': tecMin.text,
                                      'max_capacity': tecMax.text
                                    });
                                    if (resp! == "success") {
                                      Get.back();
                                      commonFlushBar(context,
                                          msg: "Feed updated successfully",
                                          title: "Success");
                                    } else if (resp == "Access Denied") {
                                      Get.back();
                                      commonFlushBar(context,
                                          msg: "Access Denied");
                                    }
                                  }
                                } else {
                                  Flushbar(
                                    message: "Min or Max Capacity is Empty",
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                }
                              } else if ((selectedFeedTypeIndex == null) ||
                                  (selectedFrequencyIndex == null) ||
                                  (tecMin.text.isEmpty) ||
                                  (tecMax.text.isEmpty)) {
                                Flushbar(
                                  message: "Please fill all fields",
                                  duration: const Duration(seconds: 3),
                                ).show(context);
                              } else {
                                Flushbar(
                                  message: "Please fill all fields",
                                  duration: const Duration(seconds: 3),
                                ).show(context);
                              }
                            },
                            child: Container(
                              height: 54.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.h),
                                  color: AppColors.buttoncolour),
                              child: Center(
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 20.sp),
                                ),
                              ),
                            ),
                          ),
                          sizedBoxHeight(20.h),
                        ],
                      ),
              ),
            )
          ]),
    );
  }
}

class Feedtextformfield extends StatefulWidget {
  Feedtextformfield({
    Key? key,
    this.validator,
    this.inputFormatters,
    required this.hintText,
    required this.validatorText,
    this.textEditingController,
    this.leadingIcon,
    this.onTap,
    this.eyeIcon = false,
    this.suffixIcon,
    this.readonly = false,
    this.isInputPassword = false,
    this.outlineColor = const Color(0xFFFFB600),
    // this.keyboardType,
    this.suffixIconConstraints,
    this.texttype,
  }) : super(key: key);

  final dynamic validator;
  final TextEditingController? textEditingController;
  final String hintText;
  final String validatorText;
  final Widget? leadingIcon;
  final bool eyeIcon;
  final Widget? suffixIcon;
  final bool isInputPassword;
  void Function()? onTap;
  final bool readonly;
  final dynamic inputFormatters;
  final Color outlineColor;
  final BoxConstraints? suffixIconConstraints;

  final TextInputType? texttype;

  @override
  State<Feedtextformfield> createState() => _FeedtextformfieldState();
}

class _FeedtextformfieldState extends State<Feedtextformfield> {
  late bool obscureText;
  // late bool eyeseIcon;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isInputPassword;
    // eyeseIcon = widget.eyeIcon;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      //height: 50.h,
      child:

          //   Padding(
          // padding: EdgeInsets.only(right: 80.w, top: 10.h, bottom: 10.h),
          // child:
          TextFormField(
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 16.sp,
              ),
              // hin
              // onTap: ontap,

              readOnly: widget.readonly,
              cursorColor: const Color(0xFF3B3F43),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: obscureText,
              controller: widget.textEditingController,
              onTap: widget.onTap,
              decoration: InputDecoration(
                  isDense: true,
                  errorStyle: TextStyle(fontSize: 14.sp),
                  isCollapsed: true,
                  suffixIconConstraints: const BoxConstraints(),
                  contentPadding: EdgeInsets.only(
                      left: 17.w, right: 17.w, top: 11.h, bottom: 11.h),
                  filled: true,
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xff54595f63),
                      fontSize: 15.sp,
                      fontFamily: "Poppins"),
                  hintText: widget.hintText,
                  prefixIcon: widget.leadingIcon == null
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: widget.leadingIcon!,
                        ),
                  // suffixIcon: widget.leadingIcon == null
                  //     ? null
                  //     : Padding(
                  //         padding: const EdgeInsets.only(left: 14, right: 14),
                  //         child: widget.leadingIcon!,
                  //       ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 20),
                  suffixIcon: widget.isInputPassword
                      ? Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: eyesuffix(),
                        )
                      : const SizedBox()),
              keyboardType: widget.texttype,
              validator: widget.validator,
              inputFormatters: widget.inputFormatters),
      // );
    );
  }

  Widget eyesuffix() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => setState(() => obscureText = !obscureText),
        child: obscureText
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Icon(
                      Icons.visibility_off,
                      color: Colors.black54,
                      size: 20.sp,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Icon(
                      Icons.visibility,
                      color: Colors.black54,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class FarmfeedDropdownBtn extends StatefulWidget {
  const FarmfeedDropdownBtn({
    required this.hint,
    required this.items,
    this.isEnabled = true,
    this.onItemSelected,
    bool showAddButton = false,
    super.key,
  });
  final String hint;
  final List<String>? items;
  final void Function(String)? onItemSelected;
  final bool isEnabled;
  @override
  State<FarmfeedDropdownBtn> createState() => _FarmfeedDropdownBtnState();
}

class _FarmfeedDropdownBtnState extends State<FarmfeedDropdownBtn> {
  late String label;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.hint,
                style: TextStyle(
                  fontSize: 18.sp,
                  //fontWeight: FontWeight.bold,
                  color: const Color(0xFF4D4D4D),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items!
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50.h,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFF1F1F1),
            ),
            color: const Color(0xFFF1F1F1),
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 23.sp,
          iconEnabledColor: const Color(0xFF141414),
          iconDisabledColor: const Color(0XFF141414),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,

          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xffCCCCCC),
            ),
            color: AppColors.white,
          ),
          elevation: 1,
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
