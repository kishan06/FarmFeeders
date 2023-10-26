import 'dart:ffi';

import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/TrainingCard.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/VideosCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  String categoryindex = Get.arguments["categoryindex"];
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
            Get.toNamed("/editVideos",
                arguments: {"categoryindex": categoryindex});
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                VideosCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
