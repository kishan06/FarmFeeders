import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/view_models/UploadvideoAPI.dart';
// import 'package:farmfeeders/view/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart' as Getx hide MultipartFile, FormData;
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../Utils/networkPlayer.dart';
import '../common/flush_bar.dart';
import '../controller/sub_user_controller.dart';
import '../models/video_detail_model.dart';

String longVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

String video480 =
    "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_10mb.mp4";

String video240 =
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";

class EditVideos extends StatefulWidget {
  const EditVideos({super.key});

  @override
  State<EditVideos> createState() => _EditVideosState();
}

class _EditVideosState extends State<EditVideos> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController subtitlecontroller = TextEditingController();
  String? categoryindex;
  bool isUpdate = false;

  late VideoPlayerController videoController;

  bool state = false;
  XFile? file;
  // video

  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool videoControllerSet = false;

  setVideoPlayerController() async {
    videoController = VideoPlayerController.file(File(file!.path))
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => videoController.pause());

    print("videoController $videoController");

    // videoControllerSet = true;
    setState(() {
      videoControllerSet = true;
    });
  }

  @override
  void dispose() {
    videoController.pause();
    videoController.dispose();
    super.dispose();
  }

  DashboardController dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    categoryindex = Get.arguments["categoryindex"];
    isUpdate = Get.arguments['isUpdate'];
    subUserController.selectedIds.clear();
    if (isUpdate) {
      titlecontroller.text = dashboardController.videoData.title!;
      subtitlecontroller.text = dashboardController.videoData.smallDescription!;
      log("${ApiUrls.baseImageUrl}/${dashboardController.videoData.videoUrl}");
      videoController = VideoPlayerController.networkUrl(Uri.parse(
          "${ApiUrls.baseImageUrl}/${dashboardController.videoData.videoUrl}"))
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => videoController.pause());
      videoControllerSet = true;
    } else {
      videoController = VideoPlayerController.networkUrl(Uri.parse(
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'))
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => videoController.pause());
    }
    super.initState();

    print("videoController $videoController");

    // _videoPlayerController = VideoPlayerController.network(
    //   longVideo,
    // )..initialize().then((value) => setState(() {}));
    // _videoPlayerController2 = VideoPlayerController.network(video240);
    // _videoPlayerController3 = VideoPlayerController.network(video480);
    // _customVideoPlayerController = CustomVideoPlayerController(
    //   context: context,
    //   videoPlayerController: _videoPlayerController,
    //   customVideoPlayerSettings: _customVideoPlayerSettings,
    //   additionalVideoSources: {
    //     "240p": _videoPlayerController2,
    //     "480p": _videoPlayerController3,
    //     "720p": _videoPlayerController,
    //   },
    // );

    // _customVideoPlayerWebController = CustomVideoPlayerWebController(
    //   webVideoPlayerSettings: _customVideoPlayerWebSettings,
    // );
  }

  String? attachimage;

  List<String> fileList = [];

  _uploadcheck() async {
    try {
      List<MultipartFile> multipartFiles = [];

      if (attachimage != null) {
        fileList.add(attachimage!);

        for (String file in fileList) {
          multipartFiles.add(
            await MultipartFile.fromFile(
              file,
              filename: path.basename(file),
            ),
          );
        }
      }
      if (subUserController.selectedIds.isEmpty) {
        if (isUpdate) {
          Utils.loader();
          var formData = FormData.fromMap({});
          if (file == null) {
            formData = FormData.fromMap({
              "id": dashboardController.videoData.id,
              "title": titlecontroller.text,
              "sub_title": subtitlecontroller.text,
              "category_id": categoryindex.toString(),
            });
          } else {
            formData = FormData.fromMap({
              "id": dashboardController.videoData.id,
              "title": titlecontroller.text,
              "sub_title": subtitlecontroller.text,
              "video": multipartFiles.isNotEmpty ? multipartFiles : null,
              "category_id": categoryindex.toString(),
            });
          }

          final data = await UploadvideoAPI(formData).updatevideoApi(formData);

          if (data.status == ResponseStatus.SUCCESS) {
            utils.showToast(data.message);
            videoController.dispose();
            Get.back();
            Get.back(result: true);
          } else {
            utils.showToast(data.message);
            Get.back();
          }
        } else {
          Utils.loader();
          var formData = FormData.fromMap({
            "title": titlecontroller.text,
            "sub_title": subtitlecontroller.text,
            "video": multipartFiles.isNotEmpty ? multipartFiles : null,
            "category_id": categoryindex.toString(),
          });

          final data = await UploadvideoAPI(formData).uploadvideoApi();

          if (data.status == ResponseStatus.SUCCESS) {
            utils.showToast(data.message);
            videoController.dispose();
            Get.back();
            Get.back(result: true);
          } else {
            utils.showToast(data.message);
            Get.back();
          }
        }
      } else {
        Set<int> uniqueNumbers = subUserController.selectedIds.toSet();
        List<int> uniqueList = uniqueNumbers.toList();

        if (isUpdate) {
          Utils.loader();
          var formData = FormData.fromMap({});
          if (file == null) {
            formData = FormData.fromMap({
              "id": dashboardController.videoData.id,
              "title": titlecontroller.text,
              "sub_title": subtitlecontroller.text,
              "category_id": categoryindex.toString(),
              "access_ids[]": uniqueList,
            });
          } else {
            formData = FormData.fromMap({
              "id": dashboardController.videoData.id,
              "title": titlecontroller.text,
              "sub_title": subtitlecontroller.text,
              "video": multipartFiles.isNotEmpty ? multipartFiles : null,
              "category_id": categoryindex.toString(),
              "access_ids[]": uniqueList,
            });
          }

          final data = await UploadvideoAPI(formData).updatevideoApi(formData);

          if (data.status == ResponseStatus.SUCCESS) {
            utils.showToast(data.message);
            videoController.dispose();
            Get.back();
            Get.back(result: true);
          } else {
            utils.showToast(data.message);
            Get.back();
          }
        } else {
          Utils.loader();
          var formData = FormData.fromMap({
            "title": titlecontroller.text,
            "sub_title": subtitlecontroller.text,
            "video": multipartFiles.isNotEmpty ? multipartFiles : null,
            "category_id": categoryindex.toString(),
            "access_ids[]": uniqueList,
          });

          final data = await UploadvideoAPI(formData).uploadvideoApi();

          if (data.status == ResponseStatus.SUCCESS) {
            utils.showToast(data.message);
            videoController.dispose();
            Get.back();
            Get.back(result: true);
          } else {
            utils.showToast(data.message);
            Get.back();
          }
        }
      }
    } catch (e) {}
  }

  SubUserController subUserController = Get.put(SubUserController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        videoController.pause();
        videoController.dispose();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        videoController.pause();
                        videoController.dispose();
                        Get.back(result: true);
                      },
                      child: CircleAvatar(
                        radius: 20.h,
                        backgroundColor: AppColors.greyF1F1F1,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25.h,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    textBlack20W7000Mon(
                        isUpdate ? "Update Video" : "Add Video"),
                  ],
                ),
              ],
            ),
          ),

          // backgroundColor: Color(0xFFF5F8FA),
          elevation: 0,
          // shadowColor: Colors.black,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      isUpdate
                          ? Builder(builder: (context) {
                              if (videoControllerSet == false) {
                                setVideoPlayerController();
                              }

                              return SizedBox(
                                  height: 300.h,
                                  child: videoControllerSet
                                      ? NetworkPlayerWidget(
                                          videoController: videoController,
                                        )
                                      : const Text("Loading")
                                  // CircularProgressIndicator()
                                  );
                            })
                          : file == null
                              ? InkWell(
                                  onTap: () {
                                    builduploadprofile(true);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 185.h,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.buttoncolour,
                                          width: 2.h),
                                      borderRadius: BorderRadius.circular(27.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        )
                                      ],
                                      color: AppColors.white,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/upload.svg",
                                          height: 48.h,
                                          width: 48.h,
                                        ),
                                        sizedBoxHeight(18.h),
                                        SizedBox(
                                            width: 255.w,
                                            child: textBlack18W700Center(
                                                "Browse to choose a video"))
                                      ],
                                    ),
                                  ),
                                )
                              : Builder(builder: (context) {
                                  if (videoControllerSet == false) {
                                    setVideoPlayerController();
                                  }

                                  return SizedBox(
                                      height: 300.h,
                                      // width: 200.w,
                                      child: videoControllerSet
                                          ? NetworkPlayerWidget(
                                              videoController: videoController,
                                            )
                                          : const Text("Loading")
                                      // CircularProgressIndicator()
                                      );
                                }),
                      sizedBoxHeight(20.h),
                      isUpdate
                          ? CustomButton(
                              text: "Re-upload Video",
                              onTap: () {
                                builduploadprofile(true);
                              },
                            )
                          : file == null
                              ? const SizedBox()
                              : CustomButton(
                                  text: "Re-upload Video",
                                  onTap: () {
                                    builduploadprofile(true);
                                  },
                                ),
                      sizedBoxHeight(20.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: textBlack16W5000("Title"),
                      ),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Title Required";
                            }
                            return null;
                          },
                          textEditingController: titlecontroller,
                          hintText: "Animal Husbandry And Management",
                          validatorText: "Title Required"),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: textBlack16W5000("Subtitle"),
                      ),
                      sizedBoxHeight(8.h),
                      CustomTextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Subtitle Required";
                            }
                            return null;
                          },
                          textEditingController: subtitlecontroller,
                          hintText: "Animal Husbandry And Management",
                          validatorText: "Enter Subtitle"),
                      sizedBoxHeight(25.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textBlack25W7000("Access"),
                          SvgPicture.asset(
                            "assets/images/access_done.svg",
                            height: 25.h,
                            width: 25.h,
                          )
                        ],
                      ),
                      Divider(
                        color: AppColors.grey4D4D4D,
                        thickness: 0.5.h,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: subUserController.dataList.length,
                          itemBuilder: (ctx, index) {
                            return AccessCustomListTile(
                              title: subUserController.dataList[index]["name"],

                              addVideoPage: true,
                              id: subUserController.dataList[index]["id"],
                              isUpdate: isUpdate,
                              //sizefactor: MediaQuery.of(context).size.width * 0.4,
                            );
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CustomButton(
              text: isUpdate ? "Update" : "Upload",
              onTap: () {
                final isValid = _form.currentState?.validate();

                if (isValid!) {
                  if (isUpdate) {
                    _uploadcheck();
                  } else {
                    if (file == null) {
                      commonFlushBar(context, msg: "Video is Required");
                    } else {
                      _uploadcheck();
                    }
                  }
                }

                // UploadvideoAPI(updata).uploadvideoApi();
              },
            ),
          ),
        ),
      ),
    );
  }

  builduploadprofile(bool uploadVideo) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      builder: (context) {
        return Container(
          height: 100.h,
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (uploadVideo) {
                          _onImageButtonPressed(ImageSource.camera);
                          Get.back();
                        } else {
                          getImage(ImageSource.camera);
                          Get.back();
                        }
                        // getImage(ImageSource.camera);
                        // Get.back();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(fontSize: 15.sp),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (uploadVideo) {
                          _onImageButtonPressed(ImageSource.gallery);
                          Get.back();
                        } else {
                          getImage(ImageSource.gallery);
                          Get.back();
                        }
                        // getImage(ImageSource.gallery);
                        // Get.back();
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 30.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(fontSize: 15.sp),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    // if (_controller != null) {
    //   await _controller!.setVolume(0.0);
    // }
    // if (isVideo) {
    file = await _picker.pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 10),
    );
    if (file != null) {
      Utils.loader();
    }
    attachimage = file!.path;

    // MediaInfo? mediaInfo = await VideoCompress.compressVideo(
    //   attachimage!,
    //   quality: VideoQuality.LowQuality,
    //   deleteOrigin: false,
    // );

    attachimage = file!.path; //mediaInfo!.path;

    setState(() {
      videoControllerSet = false;
    });
    if (file != null) {
      Get.back();
    }
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      // final imagePermanent = await saveFilePermanently(image.path);

      setState(() {
        _image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}

class AccessCustomListTile extends StatefulWidget {
  AccessCustomListTile({
    super.key,
    required this.title,
    this.addVideoPage = false,
    this.id = 0,
    this.isUpdate = false,

    //required this.sizefactor
  });

  final String? title;

  bool addVideoPage;
  int id;
  bool isUpdate;
  //double sizefactor;

  @override
  State<AccessCustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<AccessCustomListTile> {
  SubUserController subUserController = Get.put(SubUserController());
  DashboardController dashboardController = Get.put(DashboardController());
  bool statecontroller = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) {
      if (dashboardController.videoData.videoAccess!
          .any((access) => access.iamPrincipalXid == widget.id)) {
        setState(() {
          statecontroller = true;
        });
        if (!subUserController.selectedIds.contains(widget.id)) {
          subUserController.selectedIds.add(widget.id);
        }
      }
    }
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.addVideoPage ? 0 : 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: 20.sp,
                // color: Color(0XFF4D4D4D),
              ),
            ),
            const Spacer(),
            FlutterSwitch(
              switchBorder: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid,
                width: 1,
                color: const Color(0xffCCCCCC),
              ),
              width: 50.0,
              height: 25.0,
              toggleColor: const Color(0xFF0E5F02),
              activeColor: AppColors.white,
              inactiveColor: Colors.white,
              inactiveToggleColor: const Color(0xff686868),
              value: statecontroller,
              onToggle: (val) {
                setState(() {
                  if (subUserController.selectedIds.contains(widget.id)) {
                    subUserController.selectedIds.remove(widget.id);
                    if (widget.isUpdate) {
                      dashboardController.videoData.videoAccess!.removeWhere(
                          (element) => element.iamPrincipalXid == widget.id);
                    }
                  } else {
                    subUserController.selectedIds.add(widget.id);
                    if (widget.isUpdate) {
                      dashboardController.videoData.videoAccess!
                          .add(VideoAccess(iamPrincipalXid: widget.id));
                    }
                  }
                  log(subUserController.selectedIds.toString());
                  statecontroller = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
