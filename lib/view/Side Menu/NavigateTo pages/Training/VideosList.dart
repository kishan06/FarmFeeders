import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/models/VideosListModel.dart';
import 'package:farmfeeders/models/video_detail_model.dart';
import 'package:farmfeeders/view_models/UploadvideoAPI.dart';
import 'package:farmfeeders/view_models/VideoListAPI.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/colors.dart';
import '../../../../common/dialog/delete_dialog.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  String? Time;
  String categoryindex = Get.arguments["categoryindex"];
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    checkSubUserPermission();
    super.initState();
  }

  DashboardController dashboardController = Get.put(DashboardController());
  bool isVisible = true;
  List<int> permissionList = [];
  Future<void> checkSubUserPermission() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> mList = (prefs.getStringList('permissionList') ?? []);
    permissionList = mList.map((i) => int.parse(i)).toList();

    if (permissionList.isNotEmpty) {
      isVisible = false;
      setState(() {});
    }
  }

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
        floatingActionButton: !isVisible
            ? null
            : GestureDetector(
                onTap: () async {
                  var result = await Get.toNamed("/editVideos", arguments: {
                    "categoryindex": categoryindex,
                    "isUpdate": false,
                  });
                  if (result == true) {
                    setState(() {});
                  }
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
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.buttoncolour,
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data?.data == null ||
                  snapshot.data!.data!.isEmpty) {
                return const Center(child: Text('No videos available'));
              }
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  Data videoData = snapshot.data!.data![index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await analytics.logEvent(
                            name: 'select_video',
                            parameters: {
                              'video_id': videoData.id!,
                              'video_title': videoData.title!,
                              'category_id': categoryindex,
                            },
                          );
                          Get.toNamed("/videosdetails", arguments: {
                            "videourl": videoData.videoUrl,
                            "title": videoData.title,
                            "publisheddate": videoData.publishedDatetime,
                            "videoId": videoData.id
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFF1F1F1),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 35.h,
                                          width: 200.w,
                                          child: Text(
                                            videoData.title ?? 'No Title',
                                            style: TextStyle(
                                              height: 1.1,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: const Color.fromARGB(
                                                  255, 224, 156, 156),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            videoData.smallDescription ??
                                                'No Description',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xFF141414)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          Utils.formattedTimeAgo(
                                              videoData.publishedDatetime ??
                                                  ""),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF4D4D4D)),
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            permissionList.isNotEmpty
                                ? const SizedBox()
                                : Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: PopupMenuButton(
                                        icon: const Icon(Icons.more_vert),
                                        itemBuilder: (context) {
                                          return [
                                            PopupMenuItem(
                                              onTap: () async {
                                                await analytics.logEvent(
                                                  name: 'add_new_video',
                                                  parameters: {
                                                    'category_id':
                                                        categoryindex,
                                                  },
                                                );
                                                UploadvideoAPI("")
                                                    .trainingVideoDetailApi(
                                                        videoData.id!)
                                                    .then((value) async {
                                                  VideoDetailModel
                                                      videoDetailModel =
                                                      VideoDetailModel.fromJson(
                                                          value.data);
                                                  dashboardController
                                                          .videoData =
                                                      videoDetailModel.data!;
                                                  var result =
                                                      await Get.toNamed(
                                                          "/editVideos",
                                                          arguments: {
                                                        "categoryindex":
                                                            categoryindex,
                                                        "isUpdate": true,
                                                      });
                                                  if (result == true) {
                                                    setState(() {});
                                                  }
                                                });
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.edit_outlined),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("Edit"),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              onTap: () {
                                                buildprofilelogoutdialog(
                                                  context,
                                                  () async {
                                                    await analytics.logEvent(
                                                      name: 'delete_video',
                                                      parameters: {
                                                        'video_id':
                                                            videoData.id!,
                                                        'video_title':
                                                            videoData.title!,
                                                      },
                                                    );
                                                    Utils.loader();
                                                    UploadvideoAPI("")
                                                        .deleteTrainingVideo(
                                                            videoData.id
                                                                .toString())
                                                        .then((value) {
                                                      Get.back();
                                                      Get.back();
                                                      setState(() {});
                                                    });
                                                  },
                                                );
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(Icons.delete_outlined),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text("Delete"),
                                                ],
                                              ),
                                            )
                                          ];
                                        },
                                      ),
                                    ),
                                  ),
                            Positioned.fill(
                                right: 18,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () async {
                                      await analytics.logEvent(
                                        name: 'toggle_video_bookmark',
                                        parameters: {
                                          'video_id': videoData.id!,
                                          'video_title': videoData.title!,
                                          'is_bookmarking':
                                              !videoData.bookmarked!,
                                        },
                                      );
                                      setState(() {
                                        videoData.bookmarked == true
                                            ? true
                                            : false;
                                        UploadvideoAPI("")
                                            .trainingVideoBookmarkApi(
                                                videoData.id!)
                                            .then((value) {});
                                        //  savevideo == 0 ? 1 : 0;
                                      });
                                    },
                                    child: !videoData.bookmarked! == true
                                        ? SizedBox(
                                            height: 40,
                                            child: SvgPicture.asset(
                                                "assets/images/saveblank.svg"))
                                        : SizedBox(
                                            height: 40,
                                            child: SvgPicture.asset(
                                                "assets/images/save.svg")),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
