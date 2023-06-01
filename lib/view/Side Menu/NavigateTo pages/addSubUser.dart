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
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  String? subuserdatecontroller;
  DateTime? _selectedDate;

  void _addSubUser() {
    final FormState? form = _form.currentState;
    if (form != null && form.validate()) {
      form.save();

      // Do something with the user credentials, such as login to the backend
      // server and navigate to the home screen.
      Get.toNamed("manageuser", arguments: {
        "name": name.text,
        "dob": subuserdatecontroller,
        "phone": phone.text,
        "email": email.text,
        "address": address.text,
      });
    }
  }

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Full Name';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        // v2 = true;
                        return null;
                      },
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
                  GestureDetector(
                    onTap: () {
                      _subUserDatePicker();
                    },
                    child: Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        border: Border.all(
                          color: Color(0xffF1F1F1),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/calender.svg"),
                                sizedBoxWidth(10.w)
                              ],
                            ),
                            Row(
                              children: [
                                sizedBoxWidth(20.w),
                                Text(
                                  _selectedDate == null
                                      ? ''
                                      : '$subuserdatecontroller',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                      validator: (value) {
                        if (value == value.isEmpty) {
                          return 'Mobile number is required';
                        } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                            .hasMatch(value)) {
                          return 'Enter valid mobile number';
                        }
                        // v3 = true;
                        return null;
                      },
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
                      validator: (value) {
                        if (value == value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // v4 = true;
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter address';
                        }
                        return null;
                      },
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
                      _addSubUser();
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

  void _subUserDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1922),
            lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return setState(() {
          subuserdatecontroller = '';
        });
      }
      setState(() {
        _selectedDate = pickedDate;
        subuserdatecontroller =
            "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }
}
