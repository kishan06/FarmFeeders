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
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16.w,
            ),
            Stack(
              children: [
                SizedBox(
                  width: 50.w,
                  child: CircleAvatar(
                    radius: 25.r,
                    backgroundColor: Colors.grey,
                    child: Image.asset(
                      recipeimage,
                      height: 50.h,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  left: 35.w,
                  child: SvgPicture.asset(
                    "assets/images/staruncheck.svg",
                    height: 22.h,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontFamily: "StudioProR",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF54595F)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  name,
                  style: TextStyle(
                      fontFamily: "StudioProR",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(59, 63, 67, 0.49)),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  newsData[index]["isFollowedByMe"] =
                      isFollowedByMe == 0 ? 1 : 0;
                });
              },
              child: isFollowedByMe == 0
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Color(0xFF3B3F43),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Center(child: Text("Following")),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade700),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.h),
                        child: Center(
                          child: Text("Follow"),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              width: 16.w,
            )
          ],
        ),
        Divider(
          endIndent: 20.w,
          indent: 20.w,
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
