import 'dart:async';

//import 'package:farmfeeders/Utils/SizedBox.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class manageUser extends StatefulWidget {
  const manageUser({super.key});

  @override
  State<manageUser> createState() => _manageUserState();
}

class _manageUserState extends State<manageUser> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final residentialstatustexteditingcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: customAppBar(text: "Manage Users"),
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
                        "Can only add 3 users",
                        style: TextStyle(
                          color: Color(0xFF4D4D4D),
                          fontFamily: 'Poppins',
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customButton(
                    text: "Add Sub Users",
                    onTap: () {
                      // if (_form.currentState!.validate()) {
                      //   print("error");
                      // }
                      Get.toNamed("/addsubuser");
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
