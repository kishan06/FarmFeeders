import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/addNote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class VideosDetails extends StatefulWidget {
  const VideosDetails({super.key});

  @override
  State<VideosDetails> createState() => _VideosDetailsState();
}

class _VideosDetailsState extends State<VideosDetails> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    VideosDetails();
    NotesData;
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
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            insetPadding: const EdgeInsets.symmetric(vertical: 10),
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
            content: Column(
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
                ),
                SizedBox(
                  height: 20.h,
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
                  SizedBox(
                      height: 230.h,
                      width: double.infinity,
                      child: const Placeholder()),
                  sizedBoxHeight(15.h),
                  Text(
                    'Animal Husbandry And Management',
                    style: TextStyle(
                        color: const Color(0xff4D4D4D),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      textGrey4D4D4D_14('1.2M Views.'),
                      sizedBoxWidth(50.w),
                      textGrey4D4D4D_14('2 years ago'),
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
                child: ListView.builder(
                  itemCount: NotesData.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        addNotes(
                          NotesData[index]["id"],
                          NotesData[index]["Content"].toString(),
                          NotesData[index]["title"].toString(),
                          NotesData[index]["time"],
                          index,
                        ),
                        sizedBoxHeight(12.h),
                      ],
                    );
                  },
                  // separatorBuilder: (context, index) {
                  //   return addNotes();
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addNotes(
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
                      text: NotesData[index]["title"],
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
                      text: NotesData[index]["Content"],
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
