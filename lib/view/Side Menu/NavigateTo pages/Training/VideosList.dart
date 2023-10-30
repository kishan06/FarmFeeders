import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/models/VideosListModel.dart';
import 'package:farmfeeders/view_models/VideoListAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  String? Time;
  String categoryindex = Get.arguments["categoryindex"];
  // Future<ResponseData<dynamic>> fetchVideoList() async {
  //   return VideoListAPI(categoryindex).videolistApi();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: customAppBar(text: "Videos"),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Get.toNamed("/editVideos", arguments: {
              "categoryindex": categoryindex,
            });
          },
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xff0E5F02),
            child: Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<VideosListModel>(
            future: VideoListAPI(categoryindex).videolistApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available.'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    Data videoData = snapshot.data!.data![index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/videosdetails", arguments: {
                              "videourl": videoData.videoUrl,
                              "title": videoData.title,
                              "publisheddate": videoData.publishedDatetime,
                              "videoId": videoData.id
                            });
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
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image.asset(
                                        "assets/images/thumbnail_icon.png",
                                        width: 70.w,
                                        height: 70.h,
                                        //   fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 41.h,
                                            width: 206.w,
                                            child: Text(
                                              videoData.title ?? 'No Title',
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
                                          videoData.smallDescription ??
                                              'No Description',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            Utils.formattedTimeAgo(
                                                videoData.publishedDatetime ??
                                                    ""),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF4D4D4D)),
                                          ),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              share();
                                            },
                                            child: Container(
                                              height: 40,
                                              child: SvgPicture.asset(
                                                "assets/images/share.svg",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                videoData.bookmarked == 1
                                                    ? 1
                                                    : 0;
                                                //  savevideo == 0 ? 1 : 0;
                                              });
                                            },
                                            child: videoData.bookmarked == 0
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
                    //  snapshot.data!.data!.isEmpty
                    //     ? Center(
                    //         child: Text("No data available"),
                    //       )
                    //     : ListTile(
                    //         title: Text(videoData.title ?? 'No Title'),
                    //         subtitle: Text(
                    //             videoData.smallDescription ?? 'No Description'),
                    //       );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<void> share() async {
  await FlutterShare.share(
    title: 'Example share',
    // text: 'Example share text',
    linkUrl: 'https://flutter.dev/',
    // chooserTitle: 'Example Chooser Title'
  );
}
