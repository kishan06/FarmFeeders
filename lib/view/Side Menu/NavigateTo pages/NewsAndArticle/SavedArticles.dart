import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsCard.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SavedArticleMain extends StatefulWidget {
  const SavedArticleMain({super.key});

  @override
  State<SavedArticleMain> createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticleMain> {
  ScrollController? _scrollviewcontroller;
  var sliderPage = 0.obs;
  final CarouselController carouselController = CarouselController();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: customAppBar(
            text: "Saved Article",
            actions: false,
          ),
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
                    children: [],
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
