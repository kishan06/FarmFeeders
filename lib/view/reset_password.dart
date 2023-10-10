import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/view_models/ResetPasswordAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:farmfeeders/common/limit_range.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // TextEditingController phoneController = TextEditingController();
  String? id;
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var args = Get.arguments;
    id = args['id'];

    // feedBackData = Get.arguments;
  }

  NetworkApiServices networkApiServices = NetworkApiServices();
  _verifycheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        "id": id.toString(),
        "password": passwordcontroller.text,
        "c_password": confirmpasscontroller.text
      };
      final resp = await ResetPasswordAPI(updata).resetpasswordApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        // int? id = resp.data['data']['id'];
        Get.toNamed(
          '/loginScreen',
        );
      } else if (resp.status == ResponseStatus.PRIVATE) {
        String? message = resp.data['data'];
        utils.showToast("$message");
      } else {
        utils.showToast(resp.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Reset Password"),

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
          child: Form(
            key: _form,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      "assets/lotties/resetPassword.json",
                      width: 200.w,
                      height: 200.w,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: textBlack16W5000(
                          "Your new password must be different from previously used password"
                          // "Please enter your phone number to receive a verification code.",
                          ),
                    ),
                    sizedBoxHeight(10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textBlack16W5000("New Password"),
                    ),
                    sizedBoxHeight(8.h),
                    CustomTextFormField(
                      // controller: passwordcontroller,
                      textEditingController: passwordcontroller,
                      // leadingIcon:
                      //     SvgPicture.asset("assets/images/password.svg"),
                      hintText: "",
                      validatorText: "",
                      isInputPassword: true,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Password can't be empty";
                        }
                        if (!RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(val)) {
                          return 'Invalid Password';

                          // return 'Password must have at least 8 characters \nPassword must have at least 1 Uppercase letter, 1 Lowercase letter, 1 symbol and 1 number';
                        } else {
                          return null;
                        }
                      },
                    ),
                    sizedBoxHeight(13.h),

                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //       // return 'Password must have at least 8 characters \nPassword must have at least 1 Uppercase letter, 1 Lowercase letter, 1 symbol and 1 number';
                    //   child: textBlack16W5000(
                    //     // "Password must have at least 8 characters \nPassword must have at least 1 Uppercase letter \nPassword must have at least 1 Lowercase letter \nPassword must have at least 1 Symbol \nPassword must have at least 1 Number"),
                    // ),

                    // sizedBoxHeight(13.h),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: textBlack16W5000("Confirm Password"),
                    ),
                    sizedBoxHeight(8.h),
                    CustomTextFormField(
                      // leadingIcon:
                      //     SvgPicture.asset("assets/images/password.svg"),
                      textEditingController: confirmpasscontroller,
                      hintText: "",
                      validatorText: "",
                      isInputPassword: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Password can't be empty";
                        }
                        if (val != passwordcontroller.text) {
                          return 'Password does not Match';
                        }
                        return null;
                      },
                    ),
                    sizedBoxHeight(70.h),
                    customButtonCurve(
                        text: "Next",
                        onTap: () {
                          _verifycheck();
                          // final isValid = _form.currentState?.validate();
                          // if (isValid!) {
                          //   Get.toNamed('/loginScreen');
                          // }
                          // else {
                          //   Get.snackbar("Error", "Please Enter Password",
                          //       margin: EdgeInsets.all(8),
                          //       snackStyle: SnackStyle.FLOATING,
                          //       snackPosition: SnackPosition.BOTTOM);
                          // }
                          // Get.toNamed("/verifyNumber");
                        }),
                    sizedBoxHeight(40.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
