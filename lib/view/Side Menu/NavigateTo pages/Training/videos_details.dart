import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/networkPlayer.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/models/NotesModel.dart';
import 'package:farmfeeders/view_models/DeleteNotesAPI.dart';
import 'package:farmfeeders/view_models/NotesListAPI.dart';
import 'package:farmfeeders/view_models/TrainingNotesAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/custom_button.dart';

class VideosDetails extends StatefulWidget {
  const VideosDetails({super.key});

  @override
  State<VideosDetails> createState() => _VideosDetailsState();
}

class _VideosDetailsState extends State<VideosDetails> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  late VideoPlayerController videoPlayerController;

  final GlobalKey<FormState> _formdairy = GlobalKey<FormState>();
  String? videourl;
  String? title;
  String? Time;
  int? videoId;
  RxBool isLoading = true.obs;
  RxBool isListEmpty = true.obs;
  List<Data> notesData = [];
  @override
  void initState() {
    super.initState();
    checkSubUserPermission();
    videourl = Get.arguments["videourl"];
    Time = Get.arguments["publisheddate"];
    videoId = Get.arguments["videoId"];
    title = Get.arguments["title"];

    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('${ApiUrls.baseImageUrl}/$videourl'))
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((_) => videoPlayerController.pause());

    NotesListAPI(videoId).noteslistApi().then((value) {
      notesData = value.data!;
      isLoading.value = false;
      if (notesData.isEmpty) {
        isListEmpty.value = true;
      } else {
        isListEmpty.value = false;
      }
    });
  }

  bool isVisible = true;
  bool isUpdate = false;
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
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    dialoBox(
      bool isUpdate,
      String title,
      desc,
      int id,
    ) {
      if (title.isNotEmpty) {
        _titleController.text = title;
      }
      if (desc.isNotEmpty) {
        _contentController.text = desc;
      }
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Row(
            children: [
              Text(
                "Notes",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                    color: const Color(0xff141414)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  _titleController.clear();
                  _contentController.clear();
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFF1F1F1),
                  radius: 15,
                  child: Icon(
                    Icons.clear,
                    color: Color(0xFF0E5F02),
                  ),
                ),
              ),
            ],
          ),
          content: Form(
            key: _formdairy,
            child: SizedBox(
              width: Get.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextFormField(
                    readonly: !isVisible ? true : false,
                    textEditingController: _titleController,
                    hintText: "",
                    validatorText: '',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Title Required";
                      }
                      return null;
                    },
                    fillColor: AppColors.white,
                    borderColor: const Color(0xFF0E5F02),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextFormField(
                    readonly: !isVisible ? true : false,
                    textEditingController: _contentController,
                    hintText: "",
                    validatorText: '',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Description Required";
                      }
                      return null;
                    },
                    fillColor: AppColors.white,
                    borderColor: const Color(0xFF0E5F02),
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  !isVisible
                      ? const SizedBox()
                      : customButton(
                          radiusValue: 25.h,
                          text: isUpdate ? "Update" : "Add",
                          onTap: () {
                            final isValid = _formdairy.currentState?.validate();
                            if (isValid!) {
                              Utils.loader();
                              if (isUpdate) {
                                TrainingNotesApi().updateNotesApi(map: {
                                  "id": id,
                                  "title": _titleController.text,
                                  "description": _contentController.text,
                                }).then((value) {
                                  _titleController.clear();
                                  _contentController.clear();
                                  Get.back();
                                  Get.back(result: true);
                                });
                              } else {
                                TrainingNotesApi().addNotesApi(map: {
                                  "id": videoId,
                                  "title": _titleController.text,
                                  "description": _contentController.text,
                                }).then((value) {
                                  _titleController.clear();
                                  _contentController.clear();
                                  isListEmpty.value = false;
                                  Get.back();
                                  Get.back(result: true);
                                });
                              }
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        videoPlayerController.pause();
        videoPlayerController.dispose();
        return true;
      },
      child: Scaffold(
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
                        videoPlayerController.pause();
                        videoPlayerController.dispose();
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
                    textBlack20W7000Mon("Video Details"),
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
        floatingActionButton: !isVisible
            ? null
            : GestureDetector(
                onTap: () async {
                  final result = await dialoBox(false, "", "", 0);
                  if (result != null) {
                    isLoading.value = true;
                    NotesListAPI(videoId).noteslistApi().then((value) {
                      notesData = value.data!;
                      isLoading.value = false;
                    });
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight(15.h),
                    // SizedBox(
                    //     height: 230.h,
                    //     width: double.infinity,
                    //     child: Placeholder()),
                    SizedBox(
                        height: 230.h,
                        // width: 200.w,
                        child: NetworkPlayerWidget(
                          videoController: videoPlayerController,
                        )

                        // CircularProgressIndicator()
                        ),
                    sizedBoxHeight(15.h),
                    Text(
                      title ?? "",
                      style: TextStyle(
                          color: const Color(0xff4D4D4D),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        textGrey4D4D4D_14(Utils.formattedTimeAgo(Time ?? "")),
                      ],
                    ),
                    sizedBoxHeight(14.h),
                    Obx(
                      () => isListEmpty.value
                          ? textGrey4D4D4D_14('Add Notes:')
                          : textGrey4D4D4D_14('Notes:'),
                    )
                  ],
                ),
              ),
              Obx(
                () => Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.buttoncolour,
                            ))
                          : notesData.isEmpty
                              ? const Center(child: Text('No Notes available'))
                              : ListView.builder(
                                  itemCount: notesData.length,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            final result = await dialoBox(
                                              true,
                                              notesData[index].title!,
                                              notesData[index].description,
                                              notesData[index].id!,
                                            );
                                            if (result != null) {
                                              isLoading.value = true;
                                              NotesListAPI(videoId)
                                                  .noteslistApi()
                                                  .then((value) {
                                                notesData = value.data!;
                                                isLoading.value = false;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(8.w),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFFF1F1F1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 5.r,
                                                      backgroundColor:
                                                          const Color(
                                                              0xff0E5F02),
                                                    ),
                                                    sizedBoxWidth(11.w),
                                                    SizedBox(
                                                      width: Get.width / 1.5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            notesData
                                                                .elementAt(
                                                                    index)
                                                                .title!,
                                                            maxLines: 5,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          sizedBoxHeight(5.h),
                                                          RichText(
                                                            text: TextSpan(
                                                              //'Text of the printing and typesetting Industry',
                                                              text: notesData
                                                                  .elementAt(
                                                                      index)
                                                                  .description!,
                                                              style: TextStyle(
                                                                fontSize: 13.sp,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          sizedBoxHeight(5.h),
                                                          RichText(
                                                            text: TextSpan(
                                                              text: Utils.convertDate(notesData
                                                                      .elementAt(
                                                                          index)
                                                                      .publishedDatetime ??
                                                                  ""),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                !isVisible
                                                    ? const SizedBox()
                                                    : Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              final result =
                                                                  await showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.info,
                                                                            color:
                                                                                Color(0xFF0E5F02),
                                                                          ),
                                                                          title:
                                                                              const Text(
                                                                            "Are you sure you want to delete?",
                                                                            style:
                                                                                TextStyle(color: Colors.black),
                                                                          ),
                                                                          content:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                onPressed: () {
                                                                                  Utils.loader();
                                                                                  DeleteNoteAPI(notesData.elementAt(index).id).deleteNoteApi().then((value) {
                                                                                    Get.back();
                                                                                    Get.back(result: true);
                                                                                  });
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  backgroundColor: const Color(0xFF0E5F02),
                                                                                ),
                                                                                child: SizedBox(
                                                                                  width: 60.w,
                                                                                  child: const Text(
                                                                                    "Yes",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              ElevatedButton(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                style: ElevatedButton.styleFrom(
                                                                                    side: const BorderSide(
                                                                                      color: Color(0xFF0E5F02),
                                                                                    ),
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    backgroundColor: Colors.white),
                                                                                child: SizedBox(
                                                                                  width: 60.w,
                                                                                  child: const Text(
                                                                                    "No",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Color(0xFF0E5F02),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                              if (result !=
                                                                  null) {
                                                                isLoading
                                                                        .value =
                                                                    true;
                                                                NotesListAPI(
                                                                        videoId)
                                                                    .noteslistApi()
                                                                    .then(
                                                                        (value) {
                                                                  notesData =
                                                                      value
                                                                          .data!;
                                                                  isLoading
                                                                          .value =
                                                                      false;
                                                                  if (notesData
                                                                      .isEmpty) {
                                                                    isListEmpty
                                                                            .value =
                                                                        true;
                                                                  } else {
                                                                    isListEmpty
                                                                            .value =
                                                                        false;
                                                                  }
                                                                });
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .delete_rounded,
                                                              size: 20.sp,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                        sizedBoxHeight(12.h),
                                      ],
                                    );
                                  },
                                  // separatorBuilder: (context, index) {
                                  //   return addNotes();
                                  // },
                                )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Notes(
    int id,
    dynamic Content,
    dynamic title,
    dynamic time,
    int index,
  ) {
    return Container(
      padding: EdgeInsets.all(8.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 5.r,
                backgroundColor: const Color(0xff0E5F02),
              ),
              sizedBoxWidth(11.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      // 'Lorem Ipsum Is Simple Dummy',
                      text: notesData.elementAt(index).title,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  sizedBoxHeight(5.h),
                  RichText(
                    text: TextSpan(
                      //'Text of the printing and typesetting Industry',
                      text: notesData.elementAt(index).description!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  sizedBoxHeight(5.h),
                  // RichText(
                  //   text: TextSpan(
                  //     text:
                  //         // '5:30 pm',
                  //         "Edited on : ${DateFormat().format(notesData[index]["time"])}",
                  //     style: TextStyle(
                  //         fontSize: 13.sp,
                  //         fontWeight: FontWeight.w300,
                  //         color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  final result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          icon: const Icon(
                            Icons.info,
                            color: Color(0xFF0E5F02),
                          ),
                          title: const Text(
                            "Are you sure you want to delete?",
                            style: TextStyle(color: Colors.black),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xFF0E5F02),
                                ),
                                child: SizedBox(
                                  width: 60.w,
                                  child: const Text(
                                    "Yes",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                      color: Color(0xFF0E5F02),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.white),
                                child: SizedBox(
                                  width: 60.w,
                                  child: const Text(
                                    "No",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF0E5F02),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                  if (result != null && result) {
                    //   deleteNote(index);
                  }
                },
                child: Icon(
                  Icons.delete_rounded,
                  size: 20.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
