import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/TrainingMainData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TrainingMainCard extends StatefulWidget {
  const TrainingMainCard({
    super.key,
  });

  @override
  State<TrainingMainCard> createState() => _TrainingMaincardState();
}

class _TrainingMaincardState extends State<TrainingMainCard> {
  int currentIndex = 0;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: TrainingMainData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TraininglistCard(
                      TrainingMainData[index]["trainingimage"],
                      TrainingMainData[index]["title"],
                      TrainingMainData[index]["route"],
                      TrainingMainData[index]["id"],
                      index,
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget TraininglistCard(
    dynamic trainingimage,
    dynamic title,
    dynamic route,
    dynamic id,
    int index,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(route, arguments: {"categoryindex": id});
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: SvgPicture.asset(
                      trainingimage,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF141414),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
