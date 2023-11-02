import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:woka/view/videoplayerwidget.dart';

class NetworkPlayerWidget extends StatefulWidget {
  NetworkPlayerWidget({super.key, required this.videoController});
  VideoPlayerController videoController;
  @override
  State<NetworkPlayerWidget> createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  final asset =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

  late CustomVideoPlayerController _customVideoPlayerController;
  @override
  void initState() {
    super.initState();

    // widget.videoController = VideoPlayerController.network(asset)
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((_) => widget.videoController.pause());
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: widget.videoController,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoController.dispose();
    _customVideoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.videoController != null &&
          widget.videoController.value.isInitialized
      ? Container(
          child: buildVideo(),
        )
      : const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

  Widget buildVideo() => GestureDetector(
        onTap: () {
          widget.videoController.value.isPlaying
              ? widget.videoController.pause()
              : widget.videoController.play();
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            buildVideoPlayer(),
            buildPlay(),
          ],
        ),
      );

  Widget buildPlay() => widget.videoController.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Image.asset(
              //   "assets/images/Vector.png",
              //   height: 50,
              // ),
              Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 80.h,
              ),
            ],
          ),
        );

  Widget buildVideoPlayer() => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController),
      );
}
