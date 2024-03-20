import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/view_models/ProfileAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/colors.dart';
import '../../common/custom_appbar.dart';

class ConfirmDeleteAccountScreen extends StatelessWidget {
  const ConfirmDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> reasonsList = [
      "Technical Issues",
      "Privacy Concerns",
      "Better Alternatives",
      "Lack of useful features",
      "Unresponsive Customer Support",
      "Changes in Pricing",
    ];
    TextEditingController textarea = TextEditingController();

    RxInt selectedIndex = 7.obs;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(Get.width, 56),
            child: Container(
                height: 56,
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: customAppBar(
                    text: "Delete Account", inBottomSheet: false))),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
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
                const Gap(30),
                Text(
                  'Reason for leaving ?',
                  style: GoogleFonts.montserrat(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(25),
                Text(
                  'Please select from below the possible reasons',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(20),
                SizedBox(
                  width: Get.width,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            childAspectRatio: 3.5,
                            mainAxisSpacing: 20),
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(
                        () => InkWell(
                          onTap: () {
                            selectedIndex.value = index;
                          },
                          child: Container(
                            height: 20,
                            decoration: BoxDecoration(
                                color: selectedIndex.value == index
                                    ? const Color(0xFF008000)
                                    : Colors.white,
                                border: Border.all(
                                  color: const Color(0xFF008000),
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Center(
                                child: Text(
                                  reasonsList[index],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex.value == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const Gap(20),
                Text(
                  'OR',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF008000),
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Text(
                  'Tell us why you are leaving ?',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                const Gap(20),
                TextField(
                  controller: textarea,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          const BorderSide(color: Color(0xFF008000), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF008000),
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide:
                          const BorderSide(color: Color(0xFF008000), width: 1),
                    ),
                  ),
                ),
                const Gap(20),
                InkWell(
                  onTap: () {
                    if (selectedIndex.value == 7 && textarea.text.isEmpty) {
                      utils.showToast("Reason is required");
                    } else {
                      Utils.loader();
                      ProfileAPI()
                          .deleteProfileApi(textarea.text)
                          .then((value) {
                        Get.back();
                        Map<String, dynamic> responseData =
                            Map<String, dynamic>.from(value.data);
                        if (responseData['success']) {
                          utils.showToast(responseData['message']);
                          utils.showToast(responseData['message']);
                          Get.offAndToNamed("loginScreen");
                        }
                      });
                    }
                  },
                  child: Container(
                    width: Get.width / 1,
                    height: 56.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF008000),
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Text(
                        'Confirm Deactivation',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const Gap(25),
                InkWell(
                  onTap: () {
                    Get.back();
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
                        'Do Not Deactivate',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
