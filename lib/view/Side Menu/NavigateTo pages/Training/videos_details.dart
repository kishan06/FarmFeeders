import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/networkPlayer.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/models/NotesModel.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/addNote.dart';
import 'package:farmfeeders/view_models/DeleteNotesAPI.dart';
import 'package:farmfeeders/view_models/NotesListAPI.dart';
import 'package:farmfeeders/view_models/TrainingNotesAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/custom_button.dart';

class VideosDetails extends StatefulWidget {
  const VideosDetails({super.key});

  @override
  State<VideosDetails> createState() => _VideosDetailsState();
}

class _VideosDetailsState extends State<VideosDetails> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  late VideoPlayerController videoController;
  final GlobalKey<FormState> _formdairy = GlobalKey<FormState>();
  String? videourl;
  String? title;
  String? Time;
  int? videoId;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    videourl = Get.arguments["videourl"];
    Time = Get.arguments["publisheddate"];
    videoId = Get.arguments["videoId"];
    title = Get.arguments["title"];
    VideosDetails();
    NotesData;
    videoController = VideoPlayerController.network(
        'https://farmflow.betadelivery.com/public/$videourl')
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => videoController.pause());
    // super.initState();
  }

  void deleteNote(int index) {
    setState(() {
      NotesData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    dialoBox() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
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
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
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
            child: Container(
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
                    borderColor: Color(0xFF0E5F02),
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
                    borderColor: Color(0xFF0E5F02),
                    maxLines: 8,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customButton(
                    radiusValue: 25.h,
                    text: "Add",
                    onTap: () {
                      final isValid = _formdairy.currentState?.validate();
                      if (isValid!) {
                        Utils.loader();
                        TrainingNotesApi().addNotesApi(map: {
                          "id": videoId,
                          "title": _titleController.text,
                          "description": _contentController.text,
                        }).then((value) {
                          _titleController.clear();
                          _contentController.clear();
                          Get.back();
                          Get.back();
                          setState(() {
                            NotesListAPI(videoId).noteslistApi();
                          });
                        });
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

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () async {
          final result = await dialoBox();
          if (result != null) {
            Map<dynamic, dynamic> map = {
              "id": NotesData.length,
              "title": result[0].toString(),
              "Content": result[1].toString(),
              "time": DateTime.now(),
            };
            NotesData.add(map);
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
                  Container(
                      height: 230.h,
                      // width: 200.w,
                      child: NetworkPlayerWidget(
                        videoController: videoController,
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
                  textGrey4D4D4D_14('Add Notes:'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: FutureBuilder<NotesModel>(
                  future: NotesListAPI(videoId).noteslistApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data?.data == null ||
                        snapshot.data!.data!.isEmpty) {
                      return Center(child: Text('No Notes available'));
                    }

                    final NotesData = snapshot.data!.data!;
                    return ListView.builder(
                      itemCount: NotesData.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 5.r,
                                        backgroundColor:
                                            const Color(0xff0E5F02),
                                      ),
                                      sizedBoxWidth(11.w),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              // 'Lorem Ipsum Is Simple Dummy',
                                              text: NotesData.elementAt(index)
                                                  .title,
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
                                              text: NotesData.elementAt(index)
                                                  .description!,
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          sizedBoxHeight(5.h),
                                          RichText(
                                            text: TextSpan(
                                              text:
                                                  // '5:30 pm',
                                                  " Edited on : ${Utils.formattedTimeAgo(NotesData.elementAt(index).publishedDatetime ?? "")}",
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black),
                                            ),
                                          ),
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
                                                  icon: Icon(
                                                    Icons.info,
                                                    color: Color(0xFF0E5F02),
                                                  ),
                                                  title: Text(
                                                    "Are you sure you want to delete?",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          DeleteNoteAPI(NotesData
                                                                      .elementAt(
                                                                          index)
                                                                  .id)
                                                              .deleteNoteApi();
                                                          Get.back();
                                                          setState(() {
                                                            NotesListAPI(
                                                                    videoId)
                                                                .noteslistApi();
                                                          });
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          backgroundColor:
                                                              Color(0xFF0E5F02),
                                                        ),
                                                        child: SizedBox(
                                                          width: 60.w,
                                                          child: Text(
                                                            "Yes",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, false);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                side:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF0E5F02),
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                backgroundColor:
                                                                    Colors
                                                                        .white),
                                                        child: SizedBox(
                                                          width: 60.w,
                                                          child: Text(
                                                            "No",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF0E5F02),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                          if (result != null && result) {
                                            deleteNote(index);
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
                            ),
                            sizedBoxHeight(12.h),
                          ],
                        );
                      },
                      // separatorBuilder: (context, index) {
                      //   return addNotes();
                      // },
                    );
                  },
                ),
              ),
            ),
          ],
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
                      text: NotesData.elementAt(index).title,
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
                      text: NotesData.elementAt(index).description!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  sizedBoxHeight(5.h),
                  RichText(
                    text: TextSpan(
                      text:
                          // '5:30 pm',
                          "Edited on : ${DateFormat().format(NotesData[index]["time"])}",
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
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
                          icon: Icon(
                            Icons.info,
                            color: Color(0xFF0E5F02),
                          ),
                          title: Text(
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
                                  backgroundColor: Color(0xFF0E5F02),
                                ),
                                child: SizedBox(
                                  width: 60.w,
                                  child: Text(
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
                                    side: BorderSide(
                                      color: Color(0xFF0E5F02),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Colors.white),
                                child: SizedBox(
                                  width: 60.w,
                                  child: Text(
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
                    deleteNote(index);
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
