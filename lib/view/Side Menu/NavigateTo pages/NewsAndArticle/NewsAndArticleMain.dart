import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/error_msg.dart';
import 'package:farmfeeders/common/loading.dart';
import 'package:farmfeeders/controller/news_article_controller.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsAndArticleMain extends StatefulWidget {
  const NewsAndArticleMain({super.key});

  @override
  State<NewsAndArticleMain> createState() => _NewsAndArticleState();
}

class _NewsAndArticleState extends State<NewsAndArticleMain> {
  ScrollController? _scrollviewcontroller;
  var sliderPage = 0.obs;
  final CarouselController carouselController = CarouselController();
  final controllerNewsArticle = Get.put(NewsArticleController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerNewsArticle.getNewsArticleData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // controllerNewsArticle.dispose();
    //  _scrollviewcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: customAppBar(
                text: "News & Article",
                actions: true,
                icon: GestureDetector(
                  onTap: () {
                    Get.toNamed("/savedarticlemain");
                  },
                  child: Icon(
                    Icons.bookmark_rounded,
                    size: 26.sp,
                    color: const Color(0xFF0E5F02),
                  ),
                )),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            titleSpacing: 0,
          ),
          backgroundColor: Colors.white,
          body: GetBuilder<NewsArticleController>(builder: (builder) {
            return controllerNewsArticle.isLoading
                ? const Loading()
                : controllerNewsArticle.newsArticlesData == null
                    ? ErrorMsg()
                    : NestedScrollView(
                        controller: _scrollviewcontroller,
                        headerSliverBuilder:
                            (BuildContext context, bool boxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: 1,
                                (context, index) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CarouselSlider.builder(
                                      carouselController: CarouselController(),
                                      itemCount: controllerNewsArticle
                                                  .newsArticlesData!
                                                  .data
                                                  .length <
                                              5
                                          ? controllerNewsArticle
                                              .newsArticlesData!.data.length
                                          : 5,
                                      itemBuilder: (context, index, realIndex) {
                                        final cardData = controllerNewsArticle
                                            .newsArticlesData!.data[index];
                                        // final data = controllerNotification.notificationData!.data[index];
                                        String originalDate =
                                            cardData.publishedDatetime;
                                        DateTime parsedDate =
                                            DateTime.parse(originalDate);
                                        String formattedDate =
                                            DateFormat('d MMM y')
                                                .format(parsedDate);
                                        return InkWell(
                                          onTap: () async {
                                            // log(cardData.smallDescription);

                                            await launchUrl(Uri.parse(
                                                cardData.smallDescription));
                                          },
                                          child: CarouselCard(
                                              type: cardData.artCategory,
                                              title: cardData.title,
                                              // description: description,
                                              date: formattedDate,
                                              imageUrl: cardData.smallImageUrl,
                                              bookmarked: cardData.bookmarked,
                                              index: index,
                                              id: cardData.id,
                                              ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          enlargeCenterPage: true,
                                          autoPlay: true,
                                          height: 169.h,
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
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () {
                                        // Get.toNamed("/articledetails");
                                      },
                                      child: newsCard()))
                            ],
                          ),
                        ),
                      );
          })),
    );
  }
}

class CarouselCard extends StatelessWidget {
  String type;
  String title;
  // String description;
  String date;
  String imageUrl;
  bool bookmarked;
  int index;
  int id;

  CarouselCard({
    super.key,
    required this.type,
    required this.title,
    // required this.description,
    required this.date,
    required this.imageUrl,
    required this.bookmarked,
    required this.index,
    required this.id,


  });
  // final CarouselController carouselController = CarouselController();
  final controllerNewsArticle = Get.put(NewsArticleController());


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
            image: NetworkImage(ApiUrls.baseImageUrl + imageUrl),
            // AssetImage("assets/images/newsback.png"),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding:
            EdgeInsets.only(top: 5.h, bottom: 4.h, right: 10.w, left: 10.w),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  // height: 28.h,
                  // width: 70.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF80B918),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      child: Text(
                        type,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 20.h,
                  backgroundColor: AppColors.greyF2F4F5,
                  child: InkWell(
                    onTap: (){
                      // print("pressed");
                      controllerNewsArticle.changeBookmark(index);
                      controllerNewsArticle.bookmarkApi(index: index,id: id.toString());
                    
                    },
                    child: bookmarked
                        ? SizedBox(
                            height: 40.h,
                            child: SvgPicture.asset("assets/images/save.svg"))
                        : SizedBox(
                            height: 40.h,
                            child:
                                SvgPicture.asset("assets/images/saveblank.svg")),
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    // Text(
                    //   "ABCIreland",
                    //   style: TextStyle(
                    //       color: Color(0xFFEEEEEE),
                    //       fontSize: 14.sp,
                    //       fontWeight: FontWeight.w300),
                    // ),
                    // SizedBox(
                    //   width: 5.w,
                    // ),
                    // CircleAvatar(
                    //   backgroundColor: Color(0xFF80B918),
                    //   radius: 7.r,
                    //   child: Icon(
                    //     Icons.check_rounded,
                    //     color: Colors.white,
                    //     size: 15.sp,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 10.w,
                    // ),
                    // Text(
                    //   "• ",
                    //   style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.h),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      // color: Colors.black.withOpacity(0.5),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Text(
                          date,
                          style: TextStyle(
                              color: const Color(0xFFEEEEEE),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )
                  ],
                ),
                sizedBoxHeight(5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.h),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),

                      // padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        // "Sustainable Farming Boosts Yields, Preserves Soil",
                        style: TextStyle(
                            color: const Color(0xFFEEEEEE),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Text(
            //     title,
            //     // "Sustainable Farming Boosts Yields, Preserves Soil",
            //     style: TextStyle(
            //         color: Color(0xFFEEEEEE),
            //         fontSize: 16.sp,
            //         fontWeight: FontWeight.w500),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
