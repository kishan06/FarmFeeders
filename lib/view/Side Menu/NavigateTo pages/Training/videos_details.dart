import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideosDetails extends StatelessWidget {
  const VideosDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CircleAvatar(
        backgroundColor: Color(0xff0E5F02),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxHeight(15.h),
                SizedBox(
                    height: 230.h,
                    width: double.infinity,
                    child: const Placeholder()),
                sizedBoxHeight(15.h),
                Text(
                  'Animal Husbandry And Management',
                  style: TextStyle(
                      color: const Color(0xff4D4D4D),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    textGrey4D4D4D_14('1.2M Views.'),
                    sizedBoxWidth(50.w),
                    textGrey4D4D4D_14('2 years ago'),
                  ],
                ),
                sizedBoxHeight(14.h),
                textGrey4D4D4D_14('Add Notes:'),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return sizedBoxHeight(12.h);
                  },
                  separatorBuilder: (context, index) {
                    return addNotes();
                  },
                  itemCount: 10),
            ),
          ),
        ],
      )),
    );
  }

  Widget addNotes() {
    return Container(
      padding: EdgeInsets.all(8.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 5.r,
                backgroundColor: const Color(0xff0E5F02),
              ),
              sizedBoxWidth(11.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lorem Ipsum Is Simple Dummy',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  Text(
                    'Text of the printing and typesetting Industry',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  Text(
                    '5:30 pm',
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.delete_rounded,
                size: 20.sp,
              ),
            ],
          )
        ],
      ),
    );
  }
}
