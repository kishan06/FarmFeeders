import 'package:another_flushbar/flushbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_dropdown.dart';
import 'package:farmfeeders/common/flush_bar.dart';
import 'package:farmfeeders/controller/farm_feed_controller.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/ConnectExpert.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Farmfeedtracker extends StatefulWidget {
  const Farmfeedtracker({super.key});

  @override
  State<Farmfeedtracker> createState() => _FarmfeedtrackerState();
}

// List feedType = [
//   {"titleText": "Dairy", "imagePath": "assets/images/dairy.png", "Updated": false},
//   {"titleText": "Beef", "imagePath": "assets/images/beef.svg", "Updated": false},
//   {"titleText": "Sheep", "imagePath": "assets/images/sheep.svg", "Updated": false},
//   {"titleText": "Pig", "imagePath": "assets/images/pig.svg", "Updated": false},
//   {"titleText": "Poultry", "imagePath": "assets/images/poultry.svg", "Updated": false},
// ];

class _FarmfeedtrackerState extends State<Farmfeedtracker> {
  bool notCollapsed = true;

  FeedInfoContro feedInfoController = Get.put(FeedInfoContro());

  // List feedType = [
  //   {"titleText": "Dairy", "imagePath": "assets/images/dairy.png", "Updated": false},
  //   {"titleText": "Beef", "imagePath": "assets/images/beef.svg", "Updated": false},
  //   {"titleText": "Sheep", "imagePath": "assets/images/sheep.svg", "Updated": false},
  //   {"titleText": "Pig", "imagePath": "assets/images/pig.svg", "Updated": false},
  //   {"titleText": "Poultry", "imagePath": "assets/images/poultry.svg", "Updated": false},
  // ];

  // 26
  // 28

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    feedInfoController.getApiFeedDropdownData();
    // feedInfoController.getApiForLiveStockData(selectedNum: selectedNum)
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      backgroundColor: Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: Color(0XFF141414),
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
                        color: Color(0XFF141414)),
                  )
                ],
              ),
            ),
            Expanded(
              child:  SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: GetBuilder<FeedInfoContro>(builder: (builder){
                return feedInfoController.isLoading 
                ? Center(child: CircularProgressIndicator())
                : 
                // feedInfoController.feedDropdownData == null 
                // ? 
                // : 
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: feedInfoController.feedDropdownData!.data.livestockType.length,
                      itemBuilder: (context, index) {
                        // final liveStockData = feedInfoController
                        return Column(
                          children: [
                            // FeedContainer(),
                            FeedContainer(
                              titleText: feedInfoController.feedDropdownData!.data.livestockType[index].name,
                              // feedInfoController.feedType[index]["titleText"], 
                              imagePath: feedInfoController.feedDropdownData!.data.livestockType[index].smallImageUrl,
                              // feedInfoController.feedType[index]["imagePath"],
                              index: index,
                              updated: feedInfoController.feedDropdownData!.data.livestockType[index].updated,
                              feedId: feedInfoController.feedDropdownData!.data.livestockType[index].id,
                            ),
                            sizedBoxHeight(15.h),

                          ],
                        );
                      },
                    ),

                    CustomButton(
                      text: "Update",
                      onTap: () {
                        isSetFeedInfo = true;
                        // Get.back();
                        Get.back(result: true);

                        // isSetLiveStockInfo = true;
                        // Get.back(result: true);
                      }),
                    // ListView.builder(itemBuilder: itemBuilder)
                    // sizedBoxHeight(20.h),
                    // FeedContainer(),
                    // sizedBoxHeight(15.h),
                    // Beef(),
                    // sizedBoxHeight(15.h),
                    // Sheep(),
                    // sizedBoxHeight(15.h),
                    // Pig(),
                    // sizedBoxHeight(15.h),
                    // Poultry(),
                    // sizedBoxHeight(20.h)
                  ],
                );
            
              })
              
            ))
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


  FeedContainer({
    super.key,
    required this.titleText,
    required this.imagePath,
    required this.index,
    required this.updated,
    required this.feedId
  });

  @override
  State<FeedContainer> createState() => _FeedContainerState();
}

class _FeedContainerState extends State<FeedContainer> {
  bool isExpanded = false;
  final GlobalKey<FormState> _formFeedContainer = GlobalKey<FormState>();

  FeedInfoContro feedInfoController = Get.put(FeedInfoContro());

  final tecCurrentFeed = TextEditingController();
  final tecQuantity = TextEditingController();
  final tecMin = TextEditingController();
  final tecMax = TextEditingController();

  String? selectedFeedType;
  int? selectedFeedTypeIndex;

  String? selectedFrequency;
  int? selectedFrequencyIndex;

  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    print((ApiUrls.baseImageUrl + widget.imagePath));
    return Container(
      decoration: BoxDecoration(
          border:
              widget.updated ? Border.all(color: AppColors.buttoncolour , width: 1.5.w) : isExpanded ? Border.all(color: const Color(0xffCCCCCC)) : null,
          color: isExpanded ? AppColors.white : AppColors.greyF1F1F1,
          borderRadius: BorderRadius.circular(10.r)),
      child: ExpansionTile(
          childrenPadding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (bool expanding) {
            setState(() {
              isExpanded = expanding;
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
              // widget.index == 0 
              // ? Image.asset(
              //   widget.imagePath,
              //   // "assets/images/FeedContainer.png",
              //   width: 59.w,
              //   height: 42.h,
              // )
              // :SizedBox(
              //   width: 59.w,
              //   height: 42.h,
              //   child: SvgPicture.asset(
              //     widget.imagePath,
              //     // "assets/images/poultry.svg",
              //     // width: 59.w,
              //     // height: 42.h,
              //   ),
              // ),
              // NetworkImage(widget.imagePath),
              Image.network((ApiUrls.baseImageUrl + widget.imagePath),
                width: 59.w,
                // width: 100.w,

                height: 42.h,
                // height: 100.h,

              ),
              sizedBoxWidth(19.w),
              Text(
                // "FeedContainer",
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
            Form(
              key: _formFeedContainer,
              child: Column(
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
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
                        ],
                        // inputFormatters: ,
                      ),
                      // sizedBoxWidth(3.w),
                      Spacer(),
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
                                color: AppColors.white, fontSize: 18.sp),
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
                    items: feedInfoController.feedDropdownData!.data.feedType.map((e) => DropdownMenuItem(
                      child: Text(
                        e.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4D4D4D),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: e.name,
                      onTap: () {
                        setState(() {
                          selectedFeedType = e.name;
                          selectedFeedTypeIndex = e.id;
                          
                        });
                        // selectedBreed = e.name;
                        // liveStockInfoController
                        //     .updateSelectedBreed(e.name);
                        // selectedBreedIndex = e.id;
                      },
                    )).toList(),
                    value: selectedFeedType,
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
                  //       hint: "select type of feed",
                  //       items: [
                  //         "Low Quality",
                  //         "High Quality",
                  //       ]),
                  // ),
                  sizedBoxHeight(30.h),
                  Text(
                    "Feed usage",
                    style: TextStyle(
                        color: Color(0XFF0E5F02),
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
                    items: feedInfoController.feedDropdownData!.data.feedFrequency.map((e) => DropdownMenuItem(
                      child: Text(
                        e.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4D4D4D),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                    )).toList(),
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
                    "Quantity",
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
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
                        ],
                      ),
                      // sizedBoxWidth(3.w),
                      Spacer(),
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
                                color: AppColors.white, fontSize: 18.sp),
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
                    height: 92.h,
                    // width: 315.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Color(0xFFF1F1F1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Min",
                            style: TextStyle(
                                color: Color(0XFF4D4D4D),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxWidth(7.w),
                          SizedBox(
                            width: 107.w,
                            // height: 46.h,
                            child: TextFormField(
                              controller: tecMin,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                              
                              cursorColor: const Color(0xFF3B3F43),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(fontSize: 14.sp),
                                isCollapsed: true,
                                suffixIconConstraints: const BoxConstraints(),
                                contentPadding: EdgeInsets.only(
                                    left: 17.w,
                                    right: 17.w,
                                    top: 15.h,
                                    bottom: 10.h),
                                filled: true,
                                fillColor: Color(0XFFFFFFFF),
                                hintStyle: TextStyle(
                                    color: const Color(0xFF4D4D4D),
                                    fontSize: 18.sp,
                                    fontFamily: "Poppins"),
                                // hintText: "     / Kgs",
                                suffixText: "/Kgs"
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  // return "Enter Min";
                                }
                                return null;
                              },
                              

                            ),
                          ),
                          sizedBoxWidth(11.w),
                          Text(
                            "Max",
                            style: TextStyle(
                                color: Color(0XFF4D4D4D),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          sizedBoxWidth(6.w),
                          SizedBox(
                            width: 107.w,
                            // height: 46.h,
                            child: TextFormField(
                              controller: tecMax,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                              ),
                              cursorColor: const Color(0xFF3B3F43),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(fontSize: 14.sp),
                                isCollapsed: true,
                                suffixIconConstraints: const BoxConstraints(),
                                contentPadding: EdgeInsets.only(
                                    left: 17.w,
                                    right: 17.w,
                                    top: 15.h,
                                    bottom: 10.h),
                                filled: true,
                                fillColor: Color(0XFFFFFFFF),
                                hintStyle: TextStyle(
                                    color: const Color(0xFF4D4D4D),
                                    fontSize: 18.sp,
                                    fontFamily: "Poppins"),
                                // hintText: "     / Kgs",
                                suffixText: "/Kgs"
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  // return "Enter Max";
                                   
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  sizedBoxHeight(24.h),
                  buttonPressed
                  ? Center(child: CircularProgressIndicator())
                  : InkWell(
                    onTap: () async {
                        // feedInfoController.changeUpdated(widget.index);

                      final isValid = _formFeedContainer.currentState?.validate();
                      if (isValid!) {
                        setState(() {
                          buttonPressed = true;
                        });
                        final resp = await feedInfoController.setApiFarmFeed(map:  {
                          'livestock_type': widget.feedId.toString(),
                          'current_feed': tecCurrentFeed.text,
                          'feed_type': selectedFeedTypeIndex.toString(),
                          'feed_frequency': selectedFrequencyIndex.toString(),
                          'qty_per_seed': tecQuantity.text,
                          'min_capacity': tecMin.text,
                          'max_capacity': tecMax.text
                        });
                        if (resp!) {
                          commonFlushBar(context, msg: "Feed updated successfully", title: "Success");
                          feedInfoController.changeUpdated(widget.index);
                          setState(() {
                            buttonPressed = false;
                          });
                        } else {
                          commonFlushBar(context, msg: "Something went wrong");
                          setState(() {
                            buttonPressed = false;
                          });
                        }
                        // feedInfoController.changeUpdated(widget.index);
                        // Get.back();
                        // isSetFeedInfo = true;
                        // Get.to(LetsSetUpYourFarm())
                        // Get.toNamed("/letsSetUpYourFarm");

                      } else if( (selectedFeedTypeIndex == null) || (selectedFrequencyIndex == null) || (tecMin.text.isEmpty) || (tecMax.text.isEmpty)) {
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
            )
          ]),
    );
  }
}

// class Beef extends StatefulWidget {
//   Beef({
//     super.key,
//   });

//   @override
//   State<Beef> createState() => _BeefState();
// }

// class _BeefState extends State<Beef> {
//   bool isExpanded = false;
//   final GlobalKey<FormState> _formbeef = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           border:
//               isExpanded ? Border.all(color: const Color(0xffCCCCCC)) : null,
//           color: isExpanded ? AppColors.white : AppColors.greyF1F1F1,
//           borderRadius: BorderRadius.circular(10.r)),
//       child: ExpansionTile(
//           childrenPadding:
//               EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
//           initiallyExpanded: isExpanded,
//           onExpansionChanged: (bool expanding) {
//             setState(() {
//               isExpanded = expanding;
//             });
//           },
//           trailing: Icon(
//             isExpanded
//                 ? Icons.keyboard_arrow_up_rounded
//                 : Icons.keyboard_arrow_down_rounded,
//             size: 25.sp,
//             color: isExpanded ? Colors.black : Colors.black,
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SvgPicture.asset(
//                 "assets/images/beef.svg",
//                 width: 59.w,
//                 height: 42.h,
//               ),
//               sizedBoxWidth(30.w),
//               Text(
//                 "Beef",
//                 style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           children: <Widget>[
//             Form(
//               key: _formbeef,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Divider(
//                     thickness: 1,
//                     color: Colors.grey,
//                   ),
//                   Text(
//                     "Current feed on farm?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxWidth(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Feed",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Feed";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Type of feed ?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select type of feed",
//                         items: [
//                           "Low Quality",
//                           "High Quality",
//                         ]),
//                   ),
//                   sizedBoxHeight(30.h),
//                   Text(
//                     "Feed usage",
//                     style: TextStyle(
//                         color: Color(0XFF0E5F02),
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Frequency",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select frequency",
//                         items: [
//                           "1 Times a day",
//                           "2 Times a day",
//                           "3 Times a day",
//                         ]),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Quantity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Quantity",
//                         texttype: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Quantity";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Bin Capacity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Container(
//                     height: 92.h,
//                     width: 315.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       color: Color(0xFFF1F1F1),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 6.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Min",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(7.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           sizedBoxWidth(11.w),
//                           Text(
//                             "Max",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(6.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(24.h),
//                   InkWell(
//                     onTap: () {
//                       final isValid = _formbeef.currentState?.validate();
//                       if (isValid!) {
//                         Get.back();
//                       } else {
//                         Flushbar(
//                           message: "Please fill all fields",
//                           duration: const Duration(seconds: 3),
//                         ).show(context);
//                       }
//                     },
//                     child: Container(
//                       height: 54.h,
//                       width: 330.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.h),
//                           color: AppColors.buttoncolour),
//                       child: Center(
//                         child: Text(
//                           "Update",
//                           style: TextStyle(
//                               color: AppColors.white, fontSize: 20.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(20.h),
//                 ],
//               ),
//             )
//           ]),
//     );
//   }
// }

// class Sheep extends StatefulWidget {
//   Sheep({
//     super.key,
//   });

//   @override
//   State<Sheep> createState() => _SheepState();
// }

// class _SheepState extends State<Sheep> {
//   bool isExpanded = false;
//   final GlobalKey<FormState> _formsheep = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           border:
//               isExpanded ? Border.all(color: const Color(0xffCCCCCC)) : null,
//           color: isExpanded ? AppColors.white : AppColors.greyF1F1F1,
//           borderRadius: BorderRadius.circular(10.r)),
//       child: ExpansionTile(
//           childrenPadding:
//               EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
//           initiallyExpanded: isExpanded,
//           onExpansionChanged: (bool expanding) {
//             setState(() {
//               isExpanded = expanding;
//             });
//           },
//           trailing: Icon(
//             isExpanded
//                 ? Icons.keyboard_arrow_up_rounded
//                 : Icons.keyboard_arrow_down_rounded,
//             size: 25.sp,
//             color: isExpanded ? Colors.black : Colors.black,
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               sizedBoxWidth(10.w),
//               SvgPicture.asset(
//                 "assets/images/sheep.svg",
//                 width: 59.w,
//                 height: 42.h,
//               ),
//               sizedBoxWidth(31.w),
//               Text(
//                 "Sheep",
//                 style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           children: <Widget>[
//             Form(
//               key: _formsheep,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Divider(
//                     thickness: 1,
//                     color: Colors.grey,
//                   ),
//                   Text(
//                     "Current feed on farm?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxWidth(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Feed",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Feed";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Type of feed ?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select type of feed",
//                         items: [
//                           "Low Quality",
//                           "High Quality",
//                         ]),
//                   ),
//                   sizedBoxHeight(30.h),
//                   Text(
//                     "Feed usage",
//                     style: TextStyle(
//                         color: Color(0XFF0E5F02),
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Frequency",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select frequency",
//                         items: [
//                           "1 Times a day",
//                           "2 Times a day",
//                           "3 Times a day",
//                         ]),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Quantity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Quantity",
//                         texttype: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Quantity";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Bin Capacity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Container(
//                     height: 92.h,
//                     width: 315.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       color: Color(0xFFF1F1F1),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 6.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Min",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(7.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           sizedBoxWidth(11.w),
//                           Text(
//                             "Max",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(6.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(24.h),
//                   InkWell(
//                     onTap: () {
//                       final isValid = _formsheep.currentState?.validate();
//                       if (isValid!) {
//                         Get.back();
//                       } else {
//                         Flushbar(
//                           message: "Please fill all fields",
//                           duration: const Duration(seconds: 3),
//                         ).show(context);
//                       }
//                     },
//                     child: Container(
//                       height: 54.h,
//                       width: 330.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.h),
//                           color: AppColors.buttoncolour),
//                       child: Center(
//                         child: Text(
//                           "Update",
//                           style: TextStyle(
//                               color: AppColors.white, fontSize: 20.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(20.h),
//                 ],
//               ),
//             )
//           ]),
//     );
//   }
// }

// class Pig extends StatefulWidget {
//   Pig({
//     super.key,
//   });

//   @override
//   State<Pig> createState() => _PigState();
// }

// class _PigState extends State<Pig> {
//   bool isExpanded = false;
//   final GlobalKey<FormState> _formpig = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           border:
//               isExpanded ? Border.all(color: const Color(0xffCCCCCC)) : null,
//           color: isExpanded ? AppColors.white : AppColors.greyF1F1F1,
//           borderRadius: BorderRadius.circular(10.r)),
//       child: ExpansionTile(
//           childrenPadding:
//               EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
//           initiallyExpanded: isExpanded,
//           onExpansionChanged: (bool expanding) {
//             setState(() {
//               isExpanded = expanding;
//             });
//           },
//           trailing: Icon(
//             isExpanded
//                 ? Icons.keyboard_arrow_up_rounded
//                 : Icons.keyboard_arrow_down_rounded,
//             size: 25.sp,
//             color: isExpanded ? Colors.black : Colors.black,
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SvgPicture.asset(
//                 "assets/images/pig.svg",
//                 width: 59.w,
//                 height: 42.h,
//               ),
//               sizedBoxWidth(15.w),
//               Text(
//                 "Pig",
//                 style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           children: <Widget>[
//             Form(
//               key: _formpig,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Divider(
//                     thickness: 1,
//                     color: Colors.grey,
//                   ),
//                   Text(
//                     "Current feed on farm?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxWidth(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Feed",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Feed";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Type of feed ?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select type of feed",
//                         items: [
//                           "Low Quality",
//                           "High Quality",
//                         ]),
//                   ),
//                   sizedBoxHeight(30.h),
//                   Text(
//                     "Feed usage",
//                     style: TextStyle(
//                         color: Color(0XFF0E5F02),
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Frequency",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select frequency",
//                         items: [
//                           "1 Times a day",
//                           "2 Times a day",
//                           "3 Times a day",
//                         ]),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Quantity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Quantity",
//                         texttype: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Quantity";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Bin Capacity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Container(
//                     height: 92.h,
//                     width: 315.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       color: Color(0xFFF1F1F1),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 6.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Min",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(7.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           sizedBoxWidth(11.w),
//                           Text(
//                             "Max",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(6.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(24.h),
//                   InkWell(
//                     onTap: () {
//                       final isValid = _formpig.currentState?.validate();
//                       if (isValid!) {
//                         Get.back();
//                       } else {
//                         Flushbar(
//                           message: "Please fill all fields",
//                           duration: const Duration(seconds: 3),
//                         ).show(context);
//                       }
//                     },
//                     child: Container(
//                       height: 54.h,
//                       width: 330.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.h),
//                           color: AppColors.buttoncolour),
//                       child: Center(
//                         child: Text(
//                           "Update",
//                           style: TextStyle(
//                               color: AppColors.white, fontSize: 20.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(20.h),
//                 ],
//               ),
//             )
//           ]),
//     );
//   }
// }

// class Poultry extends StatefulWidget {
//   Poultry({
//     super.key,
//   });

//   @override
//   State<Poultry> createState() => _PoultryState();
// }

// class _PoultryState extends State<Poultry> {
//   bool isExpanded = false;
//   final GlobalKey<FormState> _formpoultry = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           border:
//               isExpanded ? Border.all(color: const Color(0xffCCCCCC)) : null,
//           color: isExpanded ? AppColors.white : AppColors.greyF1F1F1,
//           borderRadius: BorderRadius.circular(10.r)),
//       child: ExpansionTile(
//           childrenPadding:
//               EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.w),
//           initiallyExpanded: isExpanded,
//           onExpansionChanged: (bool expanding) {
//             setState(() {
//               isExpanded = expanding;
//             });
//           },
//           trailing: Icon(
//             isExpanded
//                 ? Icons.keyboard_arrow_up_rounded
//                 : Icons.keyboard_arrow_down_rounded,
//             size: 25.sp,
//             color: isExpanded ? Colors.black : Colors.black,
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               sizedBoxWidth(25.w),
//               SvgPicture.asset(
//                 "assets/images/poultry.svg",
//                 width: 59.w,
//                 height: 42.h,
//               ),
//               sizedBoxWidth(31.w),
//               Text(
//                 "Poultry",
//                 style: TextStyle(
//                     color: AppColors.black,
//                     fontFamily: "Poppins",
//                     fontSize: 22.sp,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           children: <Widget>[
//             Form(
//               key: _formpoultry,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Divider(
//                     thickness: 1,
//                     color: Colors.grey,
//                   ),
//                   Text(
//                     "Current feed on farm?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxWidth(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Feed",
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Feed";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Type of feed ?",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select type of feed",
//                         items: [
//                           "Low Quality",
//                           "High Quality",
//                         ]),
//                   ),
//                   sizedBoxHeight(30.h),
//                   Text(
//                     "Feed usage",
//                     style: TextStyle(
//                         color: Color(0XFF0E5F02),
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Frequency",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   SizedBox(
//                     width: 315.w,
//                     height: 50.h,
//                     child: const FarmfeedDropdownBtn(
//                         hint: "select frequency",
//                         items: [
//                           "1 Times a day",
//                           "2 Times a day",
//                           "3 Times a day",
//                         ]),
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Quantity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Feedtextformfield(
//                         hintText: "",
//                         validatorText: "Please Enter Quantity",
//                         texttype: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Please Enter Quantity";
//                           }
//                           return null;
//                         },
//                       ),
//                       sizedBoxWidth(3.w),
//                       Container(
//                         height: 50.h,
//                         width: 62.w,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.h),
//                             color: AppColors.buttoncolour),
//                         child: Center(
//                           child: Text(
//                             "Kgs",
//                             style: TextStyle(
//                                 color: AppColors.white, fontSize: 18.sp),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   sizedBoxHeight(14.h),
//                   Text(
//                     "Bin Capacity",
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: "Poppins",
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   sizedBoxHeight(6.h),
//                   Container(
//                     height: 92.h,
//                     width: 315.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.r),
//                       color: Color(0xFFF1F1F1),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 6.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Min",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(7.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                           sizedBoxWidth(11.w),
//                           Text(
//                             "Max",
//                             style: TextStyle(
//                                 color: Color(0XFF4D4D4D),
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                           sizedBoxWidth(6.w),
//                           SizedBox(
//                             width: 107.w,
//                             height: 46.h,
//                             child: TextFormField(
//                               textAlignVertical: TextAlignVertical.center,
//                               style: TextStyle(
//                                 fontSize: 18.sp,
//                               ),
//                               cursorColor: const Color(0xFF3B3F43),
//                               autovalidateMode:
//                                   AutovalidateMode.onUserInteraction,
//                               decoration: InputDecoration(
//                                 errorStyle: TextStyle(fontSize: 14.sp),
//                                 isCollapsed: true,
//                                 suffixIconConstraints: const BoxConstraints(),
//                                 contentPadding: EdgeInsets.only(
//                                     left: 17.w,
//                                     right: 17.w,
//                                     top: 15.h,
//                                     bottom: 10.h),
//                                 filled: true,
//                                 fillColor: Color(0XFFFFFFFF),
//                                 hintStyle: TextStyle(
//                                     color: const Color(0xFF4D4D4D),
//                                     fontSize: 18.sp,
//                                     fontFamily: "Poppins"),
//                                 hintText: "     / Kgs",
//                               ),
//                               keyboardType: TextInputType.number,
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return;
//                                 }
//                                 return null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(24.h),
//                   InkWell(
//                     onTap: () {
//                       final isValid = _formpoultry.currentState?.validate();
//                       if (isValid!) {
//                         Get.back();
//                       } else {
//                         Flushbar(
//                           message: "Please fill all fields",
//                           duration: const Duration(seconds: 3),
//                         ).show(context);
//                       }
//                     },
//                     child: Container(
//                       height: 54.h,
//                       width: 330.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.h),
//                           color: AppColors.buttoncolour),
//                       child: Center(
//                         child: Text(
//                           "Update",
//                           style: TextStyle(
//                               color: AppColors.white, fontSize: 20.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                   sizedBoxHeight(20.h),
//                 ],
//               ),
//             )
//           ]),
//     );
//   }
// }

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
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
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
                      color: const Color(0xFF54595F63),
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
                      : SizedBox()),
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
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.hint,
                style: TextStyle(
                  fontSize: 18.sp,
                  //fontWeight: FontWeight.bold,
                  color: Color(0xFF4D4D4D),
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
              color: Color(0xFFF1F1F1),
            ),
            color: Color(0xFFF1F1F1),
          ),
          elevation: 0,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 23.sp,
          iconEnabledColor: Color(0xFF141414),
          iconDisabledColor: Color(0XFF141414),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,

          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xffCCCCCC),
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
