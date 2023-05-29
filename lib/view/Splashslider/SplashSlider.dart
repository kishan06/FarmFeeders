import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/view/Splashslider/Content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SplashSlider extends StatefulWidget {
  const SplashSlider({Key? key}) : super(key: key);

  @override
  _SplashSliderState createState() => _SplashSliderState();
}

class _SplashSliderState extends State<SplashSlider> {
  int currentIndex = 0;

  late PageController _controller;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemCount: contents.length,
                  itemBuilder: (_, i) {
                    return Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.asset(
                            contents[i].image,
                            width: 390.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          height: 38.h,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            contents[i].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF000000),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 19.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 42.w),
                          child: Text(
                            contents[currentIndex].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0XFF4D4D4D),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(height: 36.h),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(contents.length, (index) => buildDot(index))),
            SizedBox(height: 70.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex < 2 
                ?
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/loginScreen"); //change the page navigation
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: const Text(
                      "Skip",
                      style: TextStyle(fontSize: 20, color: Color(0Xff0E5F02)),
                    ),
                  ),
                )
                :
                const Text(
                      "",
                      style: TextStyle(fontSize: 20, color: Color(0Xff0E5F02)),
                    ),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _controller.animateToPage(currentIndex + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                        if (currentIndex == 2) {
                          Get.toNamed(
                              "/loginScreen"); //change the page navigation

                          //  Get.toNamed(
                          //     "/notification");
                        }
                      });
                    },
                    child: SvgPicture.asset(
                      contents[currentIndex].arrow,
                      height: 56.h,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 45.w,
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      height: 7.w,
      width: currentIndex == index ? 34.w : 6.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: currentIndex == index ? Color(0XFf0E5F02) : Color(0XFf0E5F02),
      ),
    );
  }
}
