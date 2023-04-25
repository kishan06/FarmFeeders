import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/view/Splashslider/Content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashSlider extends StatefulWidget {
  const SplashSlider({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashSliderState createState() => _SplashSliderState();
}

class _SplashSliderState extends State<SplashSlider> {
  int currentIndex = 0;

  // var currentIndex = 0.obs;

  //late PageController _controller;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    //_controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
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
            SizedBox(
              height: 520.h,
              child: PageView.builder(

                  //controller: _controller,
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
                        Image.asset(
                          contents[i].image,
                          // width: 390.w,
                          // height: 420.h,
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
                        Text(
                          contents[currentIndex].description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.sp,
                            //fontWeight: FontWeight.w500,
                            color: Color(0XFF4D4D4D),
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
            SizedBox(height: 30.h),
            Row(
              children: const [
                Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0Xff0E5F02)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      height: 7.w,
      width:
          //45.w,
          currentIndex == index ? 34.w : 6.w,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.h),
        color: currentIndex == index ? Color(0XFf0E5F02) : Color(0XFf0E5F02),
      ),
    );
  }
}
