import 'dart:async';

import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/view_models/VerifyNumberAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:http/http.dart' as http;

import '../Utils/api_urls.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({super.key});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  late Timer _timer;
  int _countdown = 120;
  int? id;
  String? phonenumber;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    var args = Get.arguments;
    id = args['id'];
    phonenumber = args['phonenumber'];

    // feedBackData = Get.arguments;
  }

  resendOtpApi(String id) async {
    try {
      print(id);
      var headers = {
        'Authorization':
            'Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU='
      };
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            ApiUrls.resendOtpApi,
          ));
      request.fields.addAll({'id': id});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var resp = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        _countdown = 120;
        startTimer();
        Fluttertoast.showToast(msg: "OTP resent successfully");

        print(resp);
      } else if (response.statusCode == 429) {
        print(resp);
        Fluttertoast.showToast(
            msg: "You can resend OTP only after a 2-minute interval");
      } else {
        print(response.reasonPhrase);
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          timer.cancel();

          utils.showToast("OTP Expired");
        }
      });
    });
  }

  NetworkApiServices networkApiServices = NetworkApiServices();
  _verifycheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Utils.loader();
      Map<String, String> updata = {
        "id": id.toString(),
        "otp": pincode.text,
      };
      final resp = await VerifyNumberAPI(updata).verifynumberApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        // int? id = resp.data['data']['id'];
        Get.back();
        _timer.cancel();
        _countdown = 120;
        pincode.clear();
        Get.toNamed('/ResetPassword', arguments: {'id': id.toString()});
      } else if (resp.status == ResponseStatus.PRIVATE) {
        Get.back();
        String? message = resp.data['data'];
        utils.showToast("$message");
      } else {
        Get.back();
        utils.showToast(resp.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Verify Your Number"),

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
              children: [
                Lottie.asset("assets/lotties/verifyNumber.json",
                    width: 200.w, height: 200.w),

                SizedBox(
                  width: 270.w,
                  child: textBlack16W5000(
                      "Please enter the 4 digit code sent to $phonenumber"),
                ),

                sizedBoxHeight(45.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: PinCodeTextField(
                    showCursor: true,
                    cursorColor: const Color(0xFF143C6D),
                    textStyle:
                        TextStyle(fontSize: 18.sp, color: AppColors.black),
                    errorTextSpace: 30.h,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please Enter verification code";
                      } else if (value != null && value.length < 4) {
                        return "Please Enter 4 digit Otp";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      selectedFillColor: AppColors.greyF1F1F1,
                      inactiveFillColor: AppColors.greyF1F1F1,
                      inactiveColor: AppColors.greyF1F1F1,
                      activeColor: AppColors.greyF1F1F1,
                      selectedColor: AppColors.greyF1F1F1,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.h),
                          topRight: Radius.circular(4.h)),
                      fieldHeight: 65.h,
                      fieldWidth: 50.w,
                      activeFillColor: AppColors.greyF1F1F1,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: pincode,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {});
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");

                      return true;
                    },
                    appContext: context,
                  ),
                ),

                sizedBoxHeight(30.h),
                Center(
                  child: Text(
                    '${_countdown ~/ 60}:${(_countdown % 60).toString().padLeft(2, '0')}',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                sizedBoxHeight(30.h),

                InkWell(
                  onTap: () {
                    resendOtpApi(id.toString());
                  },
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18.sp,
                        color: AppColors.buttoncolour,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                sizedBoxHeight(30.h),
                // 130
                customButtonCurve(
                    text: "Verify",
                    onTap: () {
                      _verifycheck();
                      // final isValid = _form.currentState?.validate();
                      // if (isValid!) {
                      //   Get.toNamed('/ResetPassword');
                      // }
                      // else {
                      //   Get.snackbar("Error", "Please Enter OTP",
                      //     margin: EdgeInsets.all(8),
                      //     snackStyle: SnackStyle.FLOATING,
                      //     snackPosition: SnackPosition.BOTTOM
                      //   );
                      // }
                      // Get.toNamed("/ResetPassword");
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
