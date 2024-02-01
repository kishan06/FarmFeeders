import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/controller/news_article_controller.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class newsCard extends StatefulWidget {
  // String type;
  // String title;
  // // String description;
  // String date;
  // String imageUrl;
  // bool bookmarked;
  // int listLength;
  // bool isBookmarkedList;
  newsCard({
    super.key,
    // required this.isBookmarkedList,
    // required this.type,
    // required this.title,
    // // required this.description,
    // required this.date,
    // required this.imageUrl,
    // required this.bookmarked,
    // required this.listLength,
  });

  @override
  State<newsCard> createState() => _newsState();
}

class _newsState extends State<newsCard> {
  int currentIndex = 0;

  final controllerNewsArticle = Get.put(NewsArticleController());

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controllerNewsArticle.newsArticlesData!.data.length,
              itemBuilder: (context, index) {
                final cardData =
                    controllerNewsArticle.newsArticlesData!.data[index];
                // final data = controllerNotification.notificationData!.data[index];
                String originalDate = cardData.publishedDatetime;
                DateTime parsedDate = DateTime.parse(originalDate);
                String formattedDate = DateFormat('d MMM y').format(parsedDate);
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        log(cardData.smallDescription);

                        await launchUrl(Uri.parse(cardData.smallDescription));
                      },
                      child: newslistCard(
                          imageUrl: cardData.smallImageUrl,
                          type: cardData.artCategory,
                          title: cardData.title,
                          date: formattedDate,
                          bookmarked: cardData.bookmarked,
                          id: cardData.id,
                          index: index),
                    )
                    // newslistCard(
                    //   newsData[index]["recipeimage"],
                    //   newsData[index]["title"],
                    //   newsData[index]["name"],
                    //   index,
                    //   newsData[index]["isFollowedByMe"],
                    // )
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget newslistCard({
    required String imageUrl,
    required String type,
    required String title,
    required String date,
    required bool bookmarked,
    required int index,
    required int id,

    // dynamic title,
    // dynamic type,
    // // int index,
    // required int isFollowedByMe,
  }) {
    return Column(
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 122.w,
                width: 122.w,
                child: CachedNetworkImage(
                    imageUrl: ApiUrls.baseImageUrl + imageUrl)
                // NetworkImage(imageUrl),
                //  Image.asset(
                //   recipeimage,
                // ),
                ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4D4D4D)),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    // width: 200.w,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF141414)),
                    ),
                  ),

                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "7 Feb 2023",
                        date,
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF4D4D4D)),
                      ),
                      // SizedBox(
                      //   width: 100,
                      // ),

                      // Spacer(),
                      // Container(
                      //   height: 40,
                      //   child: SvgPicture.asset(
                      //     "assets/images/share.svg",
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   newsData[index]["isFollowedByMe"] =
                          //       isFollowedByMe == 0 ? 1 : 0;
                          // });
                        },
                        child: InkWell(
                          onTap: () {
                            controllerNewsArticle.changeBookmark(index);
                            controllerNewsArticle.bookmarkApi(
                                index: index, id: id.toString());
                          },
                          child: bookmarked
                              ? Container(
                                  height: 40,
                                  child: SvgPicture.asset(
                                      "assets/images/save.svg"))
                              : Container(
                                  height: 40,
                                  child: SvgPicture.asset(
                                      "assets/images/saveblank.svg")),
                        ),

                        // SvgPicture.asset("assets/images/save.svg")),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
            // endIndent: 20.w,
            // indent: 20.w,
            ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
