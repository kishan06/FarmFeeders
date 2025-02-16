import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/data/network/network_api_services.dart';
import 'package:farmfeeders/view_models/ContactusAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:farmfeeders/common/limit_range.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final residentialstatustexteditingcontroller = TextEditingController();
  NetworkApiServices networkApiServices = NetworkApiServices();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    contactController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  _contactuscheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        // "name": nameController.text,
        // "email": emailController.text,
        // "contact_number": contactController.text,
        "subject": subjectController.text,
        "message": messageController.text
      };
      final resp = await ContactusAPI(updata).contactusApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        utils.showToast("Sent");
        subjectController.clear();
        messageController.clear();
        _form.currentState?.reset();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: CustomSignupAppBar(
        //   titleTxt: "",
        //   bottomtext: false,
        // ),
        body: Center(
          child: Form(
            key: _form,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Contact us",
                        style: TextStyle(
                          color: const Color(0XFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      sizedBoxHeight(30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Subject",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      ContactTextformfield(
                          textEditingController: subjectController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Subject is required';
                            }
                            return null;
                          },
                          hintText: "Enter Subject",
                          validatorText: "Please Enter Subject"),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Message",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: messageController,
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
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1),
                          ),
                          hintStyle: TextStyle(
                              color: const Color(0xFF4D4D4D), fontSize: 16.sp),
                          hintText: "Message",
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
                      SizedBox(height: 42.h),
                      CustomButton(
                        text: "Send Now",
                        onTap: () {
                          _contactuscheck();
                        },
                      ),
                      sizedBoxHeight(58.h)
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactTextformfield extends StatelessWidget {
  ContactTextformfield({
    Key? key,
    this.validator,
    this.inputFormatters,
    required this.hintText,
    required this.validatorText,
    this.textEditingController,
    this.leadingIcon,
    this.onTap,
    this.readonly = false,
    this.isInputPassword = false,
    this.outlineColor = const Color(0xFFFFB600),
    this.texttype,
  }) : super(key: key);

  final dynamic validator;
  final TextEditingController? textEditingController;
  final String hintText;
  final String validatorText;
  final Widget? leadingIcon;
  final bool isInputPassword;
  void Function()? onTap;
  final bool readonly;
  final dynamic inputFormatters;
  final Color outlineColor;

  final TextInputType? texttype;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 16.sp,
        ),
        readOnly: readonly,
        cursorColor: const Color(0xFF3B3F43),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: textEditingController,
        onTap: onTap,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 16.sp),
          isCollapsed: true,
          suffixIconConstraints: const BoxConstraints(),
          contentPadding: EdgeInsets.all(17.h),
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
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
              color: const Color(0xFF4D4D4D),
              fontSize: 16.sp,
              fontFamily: "Roboto"),
          hintText: hintText,
          prefixIcon: leadingIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: leadingIcon!,
                ),
          prefixIconConstraints: const BoxConstraints(minWidth: 20),
        ),
        keyboardType: texttype,
        validator: validator,
        inputFormatters: inputFormatters);
  }
}
