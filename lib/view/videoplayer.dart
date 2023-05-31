import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../Utils/networkPlayer.dart';

class NewVideoplayer extends StatefulWidget {
  XFile? file;

  NewVideoplayer({super.key, required this.file});

  @override
  State<NewVideoplayer> createState() => _NewVideoplayerState();
}

class _NewVideoplayerState extends State<NewVideoplayer> {
  late VideoPlayerController videoController;
  // late VideoplayerController videoplayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoController = VideoPlayerController.file(File(widget.file!.path))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => videoController.pause());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: 300.h,
            // width: 200.w,
            child: NetworkPlayerWidget(videoController: videoController)
            // : Text("Loading")
            // CircularProgressIndicator()
            ));
  }
}
