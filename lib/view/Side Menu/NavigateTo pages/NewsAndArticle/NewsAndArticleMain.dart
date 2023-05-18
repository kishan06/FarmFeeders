import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewsAndArticleMain extends StatefulWidget {
  const NewsAndArticleMain({super.key});

  @override
  State<NewsAndArticleMain> createState() => _NewsAndArticleState();
}

class _NewsAndArticleState extends State<NewsAndArticleMain> {
  ScrollController? _scrollviewcontroller;
  var sliderPage = 0.obs;
  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: customAppBar(text: "News & Article"),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: _scrollviewcontroller,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        carouselController: CarouselController(),
                        itemCount: 5,
                        itemBuilder: (context, index, realIndex) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: Container(
                              height: 159.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(15.h),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/person.png"),
                                      fit: BoxFit.fill)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 20.h),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/newImages/quotes-svgrepo-com.svg",
                                      width: 24.w,
                                      height: 15.h,
                                    ),
                                    const Spacer(),
                                    Text(""),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                            enlargeCenterPage: true,
                            autoPlay: true,
                            height: 159.h,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 3),
                            viewportFraction: 0.8,
                            onPageChanged: (index, reason) {
                              setState(() {
                                sliderPage.value = index;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    textBlack18W600Mon("Latest News"),
                  ],
                ),
                Expanded(child: newsCard())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
