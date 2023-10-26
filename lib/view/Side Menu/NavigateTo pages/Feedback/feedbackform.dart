import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/view_models/FeedbackAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

class Feedbackform extends StatefulWidget {
  const Feedbackform({super.key});

  @override
  State<Feedbackform> createState() => _FeedbackformState();
}

class _FeedbackformState extends State<Feedbackform> {
  // bool _isChecked1 = false;
  // bool _isChecked2 = false;
  // bool _isChecked3 = false;
  // bool _isChecked4 = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? feedBackData;
  int? selectedIndex;

  final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> data = Get.arguments;
    feedBackData = data["text"];
    selectedIndex = data["index"];
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // Color(0xffF1F1F1),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                  ),
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
                      sizedBoxWidth(15.w),
                      Text(
                        "Feedback",
                        style: TextStyle(
                          color: const Color(0XFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.more_vert,
                        color: AppColors.black,
                        size: 35.h,
                      )
                    ],
                  ),
                ),
                sizedBoxHeight(44.h),
                Center(
                  child: Text(
                    feedBackData!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color(0xff141414),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                sizedBoxHeight(2.h),
                Center(
                  child: Text(
                    "How did you feel while using FarmFlow?\nshare with us your experience!",
                    // "what was it? \nshare with us your experience!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xff4D4D4D),
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                sizedBoxHeight(61.h),
                TextFormField(
                  controller: _commentController,
                  style: TextStyle(fontSize: 16.sp),
                  cursorColor: const Color(0xFF3B3F43),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 16.sp),
                    contentPadding: EdgeInsets.all(17.h),
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
                        color: const Color(0xFF4D4D4D), fontSize: 16.sp),
                    hintText: "  Write a feedback",
                  ),
                  minLines: 5,
                  maxLines: null,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Message is required';
                    }
                    return null;
                  },
                ),
                sizedBoxHeight(223.h),
                customButtonCurve(
                    text: "Send Now",
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        Utils.loader();
                        var data = FormData.fromMap({
                          "experience_id": selectedIndex,
                          "comment": _commentController.text,
                        });
                        FeedbackAPI().feedbackApi(data).then((value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          _commentController.clear();
                          Get.back();
                          Get.back();
                          Get.back();
                        });
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
