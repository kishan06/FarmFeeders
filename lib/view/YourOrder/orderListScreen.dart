import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Utils/colors.dart';
import '../../Utils/sized_box.dart';
import '../../Utils/texts.dart';
import '../../common/custom_appbar.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  String textV = "";
  TextEditingController textcontroller = TextEditingController();

  @override
  void initState() {
    textV = Get.arguments["name"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(
            text: textV == "ongoing"
                ? "Ongoing Orders"
                : textV == "recurring"
                    ? "Recurring Orders"
                    : textV == "cancelled"
                        ? "Cancelled Orders"
                        : "Past Orders"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            sizedBoxHeight(10.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300.w,
                    height: 46.h,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0XFF141414),
                      ),
                      cursorColor: AppColors.black,
                      controller: textcontroller,
                      decoration: InputDecoration(
                        hintText: "Search here",
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0XFF141414),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                            top: 15.h,
                            bottom: 15.h,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/searchorder.svg",
                            width: 15.w,
                            height: 15.h,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0XFFF1F1F1),
                        contentPadding:
                            EdgeInsets.only(top: 11.h, bottom: 11.h),
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
                      ),
                    ),
                  ),
                  filter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List filterList = ['beef', 'cow', 'sheep', 'pig', 'hen'];
  Widget filter() {
    return PopupMenuButton(
      icon: SvgPicture.asset(
        'assets/images/filter.svg',
        // width: 53.w,
        // height: 60.h,
        fit: BoxFit.cover,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                itemFilter(0),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.cancel_outlined))
              ]),
              itemFilter(1),
              itemFilter(2),
              itemFilter(3),
              itemFilter(4),
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolour,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: textWhite16('Apply Now')),
                  ))
            ],
          ))
        ];
      },
    );
  }

  Widget itemFilter(int index) {
    RxBool filter = false.obs;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            activeColor: AppColors.buttoncolour,
            value: filter.value,
            onChanged: (value) {
              filter.value = !filter.value;
            },
          ),
        ),
        Image.asset('assets/images/${filterList[index]}.png',
            width: 40.w, height: 24.h),
        sizedBoxWidth(5.w),
        textblack14M(filterList[index]),
      ],
    );
  }
}
