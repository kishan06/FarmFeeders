import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class newsCard extends StatefulWidget {
  const newsCard({
    super.key,
  });

  @override
  State<newsCard> createState() => _newsState();
}

class _newsState extends State<newsCard> {
  int currentIndex = 0;

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
              itemCount: newsData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    newslistCard(
                      newsData[index]["recipeimage"],
                      newsData[index]["title"],
                      newsData[index]["name"],
                      index,
                      newsData[index]["isFollowedByMe"],
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget newslistCard(dynamic recipeimage, dynamic title, dynamic name,
      int index, int isFollowedByMe) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 122,
              width: 122.w,
              child: Image.asset(
                recipeimage,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4D4D4D)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: 200.w,
                  child: Text(
                    name,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF141414)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "7 Feb 2023",
                      style: TextStyle(fontSize: 14, color: Color(0xFF4D4D4D)),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                      height: 40,
                      child: SvgPicture.asset(
                        "assets/images/share.svg",
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          newsData[index]["isFollowedByMe"] =
                              isFollowedByMe == 0 ? 1 : 0;
                        });
                      },
                      child: isFollowedByMe == 0
                          ? Container(
                              height: 40,
                              child: SvgPicture.asset(
                                  "assets/images/saveblank.svg"))
                          : Container(
                              height: 40,
                              child:
                                  SvgPicture.asset("assets/images/save.svg")),
                    ),
                  ],
                ),
              ],
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
