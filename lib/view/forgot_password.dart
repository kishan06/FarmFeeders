import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/view_models/ForgotPasswordAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:farmfeeders/common/limit_range.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  NetworkApiServices networkApiServices = NetworkApiServices();
  _forgotcheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Utils.loader();
      Map<String, String> updata = {
        "phone_number": phoneController.text,
      };
      final resp = await ForgotPasswordAPI(updata).forgotpasswordApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        Get.back();
        int? id = resp.data['data']['id'];
        Get.toNamed('/verifyNumber',
            arguments: {'id': id, 'phonenumber': phoneController.text});
      } else if (resp.status == ResponseStatus.PRIVATE) {
        Get.back();
        String? message = resp.data['data']['phone_number'].first;
        utils.showToast("$message");
      } else {
        Get.back();
        utils.showToast("${resp.message}");
      }
    }
  }

// sing
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Forgot Password"),

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
              Form(
                key: _form,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      "assets/lotties/forgotPassword.json",
                      width: 200.w,
                      height: 200.w,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: textBlack16W5000(
                        "Please enter your phone number to receive a verification code.",
                      ),
                    ),
                    sizedBoxHeight(35.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textBlack16W5000("Phone Number"),
                    ),
                    sizedBoxHeight(8.h),
                    CustomTextFormField(
                      textEditingController: phoneController,
                      texttype: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(9),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      leadingIcon: Text(
                        "+353",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      hintText: "",
                      validator: (value) {
                        if (value == value.isEmpty) {
                          return 'Mobile number is required';
                        } else if (!value.toString().startsWith("8")) {
                          return 'Enter a valid mobile number starting with 8';
                        } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{9}$)')
                            .hasMatch(value)) {
                          return 'Enter valid mobile number';
                        }
                        // v3 = true;
                        return null;
                      },
                      validatorText: "",
                      isInputPassword: false,
                    ),
                    sizedBoxHeight(130.h),
                    customButtonCurve(
                        text: "Next",
                        onTap: () {
                          _forgotcheck();
                          // Get.toNamed("/verifyNumber");
                          // final isValid = _form.currentState?.validate();
                          // if (isValid!) {
                          //   Get.toNamed("/verifyNumber",
                          //     arguments: phoneController.text
                          //   );
                          // }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
