import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController phoneController = TextEditingController();
  int focusedValue = 0;
  List feedbackData = [
    {"image": "assets/images/bad.svg", "text": "It Was Very Bad", "id": 5},
    {"image": "assets/images/poor.svg", "text": "It Was Poor", "id": 4},
    {"image": "assets/images/medium.svg", "text": "It Was Neutral", "id": 3},
    {"image": "assets/images/good.svg", "text": "It Was Good", "id": 2},
    {
      "image": "assets/images/excellent.svg",
      "text": "It Was Excellent",
      "id": 1
    },

    // {"image":"","text":""},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(
            text: "Feedback",
            actions: false,
            icon: Icon(
              Icons.more_vert,
              size: 35.h,
              color: AppColors.black,
            )),

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
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Lottie.asset(it was
                  //   "assets/lotties/FeedBack.json",
                  //   width: 200.w,
                  //   height: 200.w,
                  // ),
                  sizedBoxHeight(25.h),

                  textBlack20W7000Mon("Rate your experience"),

                  textBlack16W5000(
                    "How did you feel while using farmflow?",
                  ),

                  const Row(),

                  sizedBoxHeight(80.h),

                  SvgPicture.asset(
                    feedbackData[focusedValue]["image"],
                    height: 82.h,
                    width: 82.h,
                  ),

                  sizedBoxHeight(15.h),

                  textBlack18W7000(feedbackData[focusedValue]["text"]),

                  sizedBoxHeight(20.h),

                  Icon(
                    Icons.expand_more,
                    size: 50.h,
                  ),

                  // SizedBox(
                  //   height: 500.h,
                  //   // height =  200.h,
                  //   child: ListWheelScrollView(
                  //     // scrollBehavior: ,

                  //     itemExtent: 82.h,
                  //     children: List.generate(10, (index) => textBlack10("2"))
                  //   ),
                  // )

                  SizedBox(
                    height: 250.h,
                    child: ScrollSnapList(
                      itemBuilder: _buildItemList,
                      itemSize: 150,
                      curve: Curves.decelerate,
                      dynamicItemSize: true,
                      onReachEnd: () {
                        print('Done!');
                      },
                      itemCount: 5,
                      onItemFocus: (val) {
                        setState(() {
                          focusedValue = val;
                        });
                        // focusedValue = val;
                      },
                    ),
                  ),

                  SizedBox(
                      // width: 300.w,
                      child: customButtonCurve(
                          text: "Next",
                          onTap: () {
                            // feedbackform
                            Get.toNamed(
                              "/feedbackform",
                              arguments: {
                                "text": feedbackData[focusedValue]["text"],
                                "index": feedbackData[focusedValue]["id"],
                              },
                            );
                          }))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  List<int> data = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];

  Widget _buildItemList(BuildContext context, int index) {
    if (index == data.length) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.buttoncolour,
        ),
      );
    }
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            feedbackData[index]["image"],
            height: 82.h,
            width: 82.h,
          ),
          // Container(
          //   color: Colors.yellow,
          //   width: 150,
          //   height: 200,
          //   child: Center(
          //     child: Text('${data[index]}',style: TextStyle(fontSize: 50.0,color: Colors.black),),
          //   ),
          // ),
        ],
      ),
    );
  }
}
