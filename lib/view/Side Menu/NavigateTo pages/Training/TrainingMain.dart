import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/TrainingCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainingMain extends StatefulWidget {
  const TrainingMain({super.key});

  @override
  State<TrainingMain> createState() => _TrainingMainState();
}

class _TrainingMainState extends State<TrainingMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: customAppBar(text: "Training"),
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
                    "Select Your Categories Of Interests",
                    style: TextStyle(
                        color: Color(0xFF4D4D4D),
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TrainingMainCard()

              //  sizedBoxHeight(58.h)
            ],
          ),
        ),
      ),
    );
  }
}
