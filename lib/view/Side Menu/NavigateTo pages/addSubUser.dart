//import 'package:farmfeeders/Utils/SizedBox.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'ContactUs.dart';

class addSubUser extends StatefulWidget {
  const addSubUser({super.key});

  @override
  State<addSubUser> createState() => _addSubUserState();
}

class _addSubUserState extends State<addSubUser> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final name = TextEditingController();
  final DOB = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: customAppBar(text: "Add Sub User"),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
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
                        "Full Name",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: name,
                      leadingIcon:
                          SvgPicture.asset("assets/images/profileimage.svg"),
                      hintText: "Full Name",
                      validatorText: "Please Enter Full Name"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Date Of Birth",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: DOB,
                      leadingIcon:
                          SvgPicture.asset("assets/images/calender.svg"),
                      hintText: "Date Of Birth",
                      validatorText: "Please Select Date Of Birth"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: phone,
                      leadingIcon: SvgPicture.asset("assets/images/phone.svg"),
                      hintText: "Phone",
                      validatorText: "Please Enter phone Number"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email Id",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: email,
                      leadingIcon: SvgPicture.asset("assets/images/mail.svg"),
                      hintText: "Email Id",
                      validatorText: "Please Enter Email Id"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: address,
                      leadingIcon:
                          SvgPicture.asset("assets/images/location.svg"),
                      hintText: "Address",
                      validatorText: "please Enter Address"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Permission",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Orders",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF4D4D4D)),
                          ),
                          Spacer(),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xFF0E5F02),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Livestock",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF4D4D4D)),
                          ),
                          Spacer(),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xFF0E5F02),
                            value: isChecked1,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked1 = value!;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Feed",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF4D4D4D)),
                          ),
                          Spacer(),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xFF0E5F02),
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  customButton(
                    text: "Submit",
                    onTap: () {
                      Get.toNamed("manageuser", arguments: {
                        "name": name.text,
                        "dob": DOB.text,
                        "phone": phone.text,
                        "email": email.text,
                        "address": address.text,
                      });
                    },
                  ),
                  sizedBoxHeight(58.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
