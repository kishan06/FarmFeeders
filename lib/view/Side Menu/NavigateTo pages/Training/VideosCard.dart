import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/VideosListData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VideosCard extends StatefulWidget {
  const VideosCard({
    super.key,
  });

  @override
  State<VideosCard> createState() => _VideosCardState();
}

class _VideosCardState extends State<VideosCard> {
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
              itemCount: VideosListData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    VideosCard(
                      VideosListData[index]["videoimage"],
                      VideosListData[index]["title"],
                      VideosListData[index]["text"],
                      VideosListData[index]["time"],
                      VideosListData[index]["route"],
                      index,
                      VideosListData[index]["savevideo"],
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget VideosCard(
    dynamic videoimage,
    dynamic title,
    dynamic text,
    dynamic time,
    dynamic route,
    int index,
    int savevideo,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed("/videosdetails");
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFFF1F1F1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 92.h,
                    width: 89.w,
                    child: Image.asset(
                      videoimage,
                    ),
                  ),
                  SizedBox(
                    width: 17.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 41.h,
                            width: 206.w,
                            child: Text(
                              title,
                              style: TextStyle(
                                height: 1.1,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF141414),
                              ),
                            ),
                          ),
                          Icon(Icons.more_vert)
                        ],
                      ),
                      Container(
                        width: 230.w,
                        child: Text(
                          text,
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF141414)),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            time,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF4D4D4D)),
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
                                VideosListData[index]["savevideo"] =
                                    savevideo == 0 ? 1 : 0;
                              });
                            },
                            child: savevideo == 0
                                ? Container(
                                    height: 40,
                                    child: SvgPicture.asset(
                                        "assets/images/saveblank.svg"))
                                : Container(
                                    height: 40,
                                    child: SvgPicture.asset(
                                        "assets/images/save.svg")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
