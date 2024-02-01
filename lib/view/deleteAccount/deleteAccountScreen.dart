import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confirmDeleteAccount.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            height: Get.height,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color(0xFF7BD47B)),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Gap(60),
                const Text(
                  'Sad to see you go',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat"),
                ),
                const Gap(35),
                SvgPicture.asset(
                  'assets/images/sad_face.svg',
                ),
                const Gap(35),
                Text(
                  'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(45),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: Get.width / 1,
                    height: 56.h,
                    decoration: BoxDecoration(
                        color: const Color(0xFF008000),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'I don\'t want to deactivate',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const Gap(30),
                InkWell(
                  onTap: () {
                    Get.to(() => const ConfirmDeleteAccountScreen());
                  },
                  child: Text(
                    'Yes I am ready to deactivate my account',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
