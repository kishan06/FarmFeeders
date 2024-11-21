import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/base_manager.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/models/expertlistModel.dart';
import 'package:farmfeeders/view/Side%20Menu/Connectexpertdata.dart';
import 'package:farmfeeders/view_models/ExpertlistAPI.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/sized_box.dart';

class ConnectExperts extends StatefulWidget {
  const ConnectExperts({super.key});

  @override
  State<ConnectExperts> createState() => _ConnectExpertsState();
}

class _ConnectExpertsState extends State<ConnectExperts> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Add these analytics event methods
  Future<void> _logExpertView(String expertType) async {
    await _analytics.logEvent(
      name: 'view_expert_list',
      parameters: {
        'expert_type': expertType, // 'Advisor', 'Vets', or 'Repairmen'
      },
    );
  }

  Future<void> _logExpertCall(
      String expertType, String expertName, String expertId) async {
    await _analytics.logEvent(
      name: 'call_expert',
      parameters: {
        'expert_type': expertType,
        'expert_name': expertName,
        'expert_id': expertId,
      },
    );
  }

  Future<void> _logExpertBookmark(String expertType, String expertName,
      String expertId, bool isBookmarked) async {
    await _analytics.logEvent(
      name: 'bookmark_expert',
      parameters: {
        'expert_type': expertType,
        'expert_name': expertName,
        'expert_id': expertId,
        'is_bookmarked': isBookmarked,
      },
    );
  }

  Future<ResponseData<dynamic>> fetchData() async {
    return ExpertListAPI().expertlistApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      radius: 20.h,
                      backgroundColor: const Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.w),
                  Text(
                    "Connect With Experts",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(20.h),
            Expanded(
              child: DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0XFf0E5F02), width: 1)),
                      child: ButtonsTabBar(
                        buttonMargin: EdgeInsets.zero,
                        contentPadding:
                            const EdgeInsets.only(left: 28, right: 28),
                        radius: 8,
                        backgroundColor: const Color(0XFf0E5F02),
                        unselectedBorderColor: Colors.white,
                        //borderWidth: 1,
                        //borderColor: Color(0XFf0E5F02),
                        unselectedBackgroundColor: const Color(0xFFFFFFFF),
                        unselectedLabelStyle:
                            const TextStyle(color: Color(0xFF0F0C0C)),
                        labelStyle: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        tabs: const [
                          Tab(
                            text: "Advisor",
                          ),
                          Tab(
                            text: "Vets",
                          ),
                          Tab(
                            text: "Repairmen",
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<ResponseData<dynamic>>(
                      future: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: AppColors.buttoncolour,
                          ));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data?.status == ResponseStatus.SUCCESS) {
                          final expertList =
                              ExpertList.fromJson(snapshot.data!.data);

                          final List<Advisors> advisors =
                              expertList.data?.advisors ?? [];
                          final List<Veterinarian> veterinarians =
                              expertList.data?.veterinarian ?? [];
                          final List<Repairmen> repairmen =
                              expertList.data?.repairmen ?? [];

                          return Expanded(
                            child: TabBarView(
                              children: [
                                // List of Advisors
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: advisors.length,
                                  itemBuilder: (context, index) {
                                    final advisor = advisors[index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                                  vertical: 7.h,
                                                  horizontal: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              border: Border.all(
                                                  color: const Color(0XFf0E5F02)
                                                      .withOpacity(1),
                                                  width: 1),
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 11.h,
                                                ),
                                                Row(
                                                  //mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 16.w),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 3,
                                                              color: advisor
                                                                      .bookmarked!
                                                                  ? Colors.amber
                                                                  : Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  100), //<-- SEE HERE
                                                        ),
                                                        child: advisor
                                                                .smallImageUrl!
                                                                .isEmpty
                                                            ? Image.asset(
                                                                // image,
                                                                "assets/default_image.jpg",
                                                                width: 66.w,
                                                                height: 66.w,
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60),
                                                                child: Image
                                                                    .network(
                                                                  "${ApiUrls.baseImageUrl}/${advisor.smallImageUrl}",
                                                                  width: 66.w,
                                                                  height: 66.w,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    sizedBoxWidth(8.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: advisor.name,
                                                            // "Roma dsouza",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/images/call.svg",
                                                              width: 13.w,
                                                              height: 13.w,
                                                            ),
                                                            sizedBoxWidth(5.w),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: advisor
                                                                    .contactNumber,
                                                                // "0225845855",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0XFF585858),
                                                                  fontSize:
                                                                      16.sp,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 3.h),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/images/locationconnect.svg",
                                                                width: 13.w,
                                                                height: 13.w,
                                                              ),
                                                            ),
                                                            sizedBoxWidth(5.w),
                                                            SizedBox(
                                                              width: 170.w,
                                                              child: RichText(
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                  text: advisor
                                                                      .location,
                                                                  // "Canada",
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color(
                                                                        0XFF585858),
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    // sizedBoxWidth(16.w),

                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              IconButton(
                                                                icon: advisor
                                                                        .bookmarked!
                                                                    ? CircleAvatar(
                                                                        radius:
                                                                            25.h,
                                                                        backgroundColor:
                                                                            const Color(0XFFF1F1F1),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .star_border,
                                                                        color: Color(
                                                                            0XFF707070),
                                                                      ),
                                                                onPressed: () {
                                                                  _logExpertBookmark(
                                                                    'Advisor', // or 'Vets' or 'Repairmen'
                                                                    advisor
                                                                        .name!,
                                                                    advisor.id!
                                                                        .toString(),
                                                                    !advisor
                                                                        .bookmarked!, // new bookmark state
                                                                  );
                                                                  ExpertListAPI()
                                                                      .updateMarkExpertApi(
                                                                          advisor
                                                                              .id!)
                                                                      .then(
                                                                          (value) {
                                                                    //  expertData[index]["isConnect"] = isConnect == 0 ? 1 : 0;
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                },
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  await _logExpertCall(
                                                                    'Advisor', // or 'Vets' or 'Repairmen' depending on tab
                                                                    advisor
                                                                        .name!, // or vet.name or repairman.name
                                                                    advisor.id!
                                                                        .toString(),
                                                                  );
                                                                  launch(
                                                                      'tel://${advisor.contactNumber}');
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7.h),
                                                                    color: AppColors
                                                                        .buttoncolour,
                                                                  ),
                                                                  height: 40,
                                                                  width: 60,
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Call",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ]),

                                                    // SvgPicture.asset(
                                                    //   "assets/images/starconnect.svg",
                                                    //   width: 38.w,
                                                    //   height: 38.w,
                                                    // ),

                                                    // CircleAvatar(
                                                    //   radius: 25.h,
                                                    //   backgroundColor: Color(0XFFF1F1F1),
                                                    //   child: Center(
                                                    //     child: Icon(
                                                    //       Icons.star,
                                                    //       size: 35.h,
                                                    //       color: Color.fromARGB(255, 248, 211, 2),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 11.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        )
                                      ],
                                    );

                                    // ListTile(
                                    //   title: Text(advisor.name ?? ''),
                                    //   subtitle:
                                    //       Text(advisor.contactNumber ?? ''),
                                    //   // You can display other information like location, image, etc.
                                    // );
                                  },
                                ),

                                // List of Veterinarians
                                ListView.builder(
                                  itemCount: veterinarians.length,
                                  itemBuilder: (context, index) {
                                    final vet = veterinarians[index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                                  vertical: 7.h,
                                                  horizontal: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              border: Border.all(
                                                  color: const Color(0XFf0E5F02)
                                                      .withOpacity(1),
                                                  width: 1),
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 11.h,
                                                ),
                                                Row(
                                                  //mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 16.w),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 3,
                                                              color: vet
                                                                      .bookmarked!
                                                                  ? Colors.amber
                                                                  : Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  100), //<-- SEE HERE
                                                        ),
                                                        child: vet
                                                                .smallImageUrl!
                                                                .isEmpty
                                                            ? Image.asset(
                                                                // image,
                                                                "assets/default_image.jpg",
                                                                width: 66.w,
                                                                height: 66.w,
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60),
                                                                child: Image
                                                                    .network(
                                                                  "${ApiUrls.baseImageUrl}/${vet.smallImageUrl}",
                                                                  width: 66.w,
                                                                  height: 66.w,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    sizedBoxWidth(8.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: vet.name,
                                                            // "Roma dsouza",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/images/call.svg",
                                                              width: 13.w,
                                                              height: 13.w,
                                                            ),
                                                            sizedBoxWidth(5.w),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: vet
                                                                    .contactNumber,
                                                                // "0225845855",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0XFF585858),
                                                                  fontSize:
                                                                      16.sp,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 3.h),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/images/locationconnect.svg",
                                                                width: 13.w,
                                                                height: 13.w,
                                                              ),
                                                            ),
                                                            sizedBoxWidth(5.w),
                                                            SizedBox(
                                                              width: 170.w,
                                                              child: RichText(
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                  text: vet
                                                                      .location,
                                                                  // "Canada",
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color(
                                                                        0XFF585858),
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    // sizedBoxWidth(16.w),

                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              IconButton(
                                                                icon: vet
                                                                        .bookmarked!
                                                                    // _isChecked
                                                                    ? CircleAvatar(
                                                                        radius:
                                                                            25.h,
                                                                        backgroundColor:
                                                                            const Color(0XFFF1F1F1),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .star_border,
                                                                        color: Color(
                                                                            0XFF707070),
                                                                      ),
                                                                onPressed: () {
                                                                  _logExpertBookmark(
                                                                    'vet', // or 'Vets' or 'Repairmen'
                                                                    vet.name!,
                                                                    vet.id!
                                                                        .toString(),
                                                                    !vet.bookmarked!, // new bookmark state
                                                                  );
                                                                  ExpertListAPI()
                                                                      .updateMarkExpertApi(vet
                                                                          .id!)
                                                                      .then(
                                                                          (value) {
                                                                    //  expertData[index]["isConnect"] = isConnect == 0 ? 1 : 0;
                                                                    setState(
                                                                        () {});
                                                                  });
                                                                },
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                        await _logExpertCall(
                                                                    'Advisor', // or 'Vets' or 'Repairmen' depending on tab
                                                                    vet
                                                                        .name!, // or vet.name or repairman.name
                                                                    vet.id!
                                                                        .toString(),
                                                                  );
                                                                  launch(
                                                                      'tel://${vet.contactNumber}');
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7.h),
                                                                    color: AppColors
                                                                        .buttoncolour,
                                                                  ),
                                                                  height: 40,
                                                                  width: 60,
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Call",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ]),

                                                    // SvgPicture.asset(
                                                    //   "assets/images/starconnect.svg",
                                                    //   width: 38.w,
                                                    //   height: 38.w,
                                                    // ),

                                                    // CircleAvatar(
                                                    //   radius: 25.h,
                                                    //   backgroundColor: Color(0XFFF1F1F1),
                                                    //   child: Center(
                                                    //     child: Icon(
                                                    //       Icons.star,
                                                    //       size: 35.h,
                                                    //       color: Color.fromARGB(255, 248, 211, 2),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 11.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        )
                                      ],
                                    );
                                  },
                                ),

                                // List of Repairmen
                                ListView.builder(
                                  itemCount: repairmen.length,
                                  itemBuilder: (context, index) {
                                    final repairman = repairmen[index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                                  vertical: 7.h,
                                                  horizontal: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              border: Border.all(
                                                  color: const Color(0XFf0E5F02)
                                                      .withOpacity(1),
                                                  width: 1),
                                              color: const Color(0xFFFFFFFF),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 11.h,
                                                ),
                                                Row(
                                                  //mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 16.w),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              width: 3,
                                                              color: repairman
                                                                      .bookmarked!
                                                                  ? Colors.amber
                                                                  : Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  100), //<-- SEE HERE
                                                        ),
                                                        child: repairman
                                                                .smallImageUrl!
                                                                .isEmpty
                                                            ? Image.asset(
                                                                // image,
                                                                "assets/default_image.jpg",
                                                                width: 66.w,
                                                                height: 66.w,
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            60),
                                                                child: Image
                                                                    .network(
                                                                  "${ApiUrls.baseImageUrl}/${repairman.smallImageUrl}",
                                                                  width: 66.w,
                                                                  height: 66.w,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    sizedBoxWidth(8.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text:
                                                                repairman.name,
                                                            // "Roma dsouza",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/images/call.svg",
                                                              width: 13.w,
                                                              height: 13.w,
                                                            ),
                                                            sizedBoxWidth(5.w),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: repairman
                                                                    .contactNumber,
                                                                // "0225845855",
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0XFF585858),
                                                                  fontSize:
                                                                      16.sp,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 3.h),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/images/locationconnect.svg",
                                                                width: 13.w,
                                                                height: 13.w,
                                                              ),
                                                            ),
                                                            sizedBoxWidth(5.w),
                                                            SizedBox(
                                                              width: 170.w,
                                                              child: RichText(
                                                                overflow:
                                                                    TextOverflow
                                                                        .clip,
                                                                text: TextSpan(
                                                                  text: repairman
                                                                      .location,
                                                                  // "Canada",
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color(
                                                                        0XFF585858),
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    // sizedBoxWidth(16.w),

                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              IconButton(
                                                                icon: repairman
                                                                        .bookmarked!
                                                                    // _isChecked
                                                                    ? CircleAvatar(
                                                                        radius:
                                                                            25.h,
                                                                        backgroundColor:
                                                                            const Color(0XFFF1F1F1),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color:
                                                                              Colors.amber,
                                                                        ),
                                                                      )
                                                                    : const Icon(
                                                                        Icons
                                                                            .star_border,
                                                                        color: Color(
                                                                            0XFF707070),
                                                                      ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _logExpertBookmark(
                                                                      'Repairman', // or 'Vets' or 'Repairmen'
                                                                      repairman
                                                                          .name!,
                                                                      repairman
                                                                          .id!
                                                                          .toString(),
                                                                      !repairman
                                                                          .bookmarked!, // new bookmark state
                                                                    );
                                                                    ExpertListAPI()
                                                                        .updateMarkExpertApi(repairman
                                                                            .id!)
                                                                        .then(
                                                                            (value) {
                                                                      //  expertData[index]["isConnect"] = isConnect == 0 ? 1 : 0;
                                                                      setState(
                                                                          () {});
                                                                    });
                                                                  });
                                                                },
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  launch(
                                                                      'tel://${repairman.contactNumber}');
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            7.h),
                                                                    color: AppColors
                                                                        .buttoncolour,
                                                                  ),
                                                                  height: 40,
                                                                  width: 60,
                                                                  child:
                                                                      const Center(
                                                                    child: Text(
                                                                      "Call",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ]),

                                                    // SvgPicture.asset(
                                                    //   "assets/images/starconnect.svg",
                                                    //   width: 38.w,
                                                    //   height: 38.w,
                                                    // ),

                                                    // CircleAvatar(
                                                    //   radius: 25.h,
                                                    //   backgroundColor: Color(0XFFF1F1F1),
                                                    //   child: Center(
                                                    //     child: Icon(
                                                    //       Icons.star,
                                                    //       size: 35.h,
                                                    //       color: Color.fromARGB(255, 248, 211, 2),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 11.h,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('Failed to load data.'));
                        }
                      },
                    ),
                    // const Expanded(
                    //   child: TabBarView(
                    //     children: [
                    //       FirstTab(),
                    //       FirstTab(),
                    //       FirstTab(),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  buildcontentcalldialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/contentcall.svg",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to call Advisor?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  final bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            sizedBoxHeight(32.h),
            // GestureDetector(
            //   onTap: () {
            //     buildcontentdialog(context);
            //   },
            //   child:
            ListView.separated(
              separatorBuilder: (context, index) {
                return sizedBoxHeight(15.h);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expertData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    connectcard(
                      expertData[index]["image"],
                      expertData[index]["tittle"],
                      expertData[index]["number"],
                      expertData[index]["location"],
                      index,
                      expertData[index]["isConnect"],
                    )
                  ],
                );
              },
            ),
            sizedBoxHeight(15.h),
          ],
        ),
      ),
    );
  }

  Widget connectcard(dynamic image, dynamic tittle, dynamic number,
      dynamic location, int index, int isConnect) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border:
            Border.all(color: const Color(0XFf0E5F02).withOpacity(1), width: 1),
        color: const Color(0xFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 11.h,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 3,
                        color: isConnect == 0 ? Colors.amber : Colors.white),
                    borderRadius: BorderRadius.circular(100), //<-- SEE HERE
                  ),
                  child: Image.asset(
                    image,
                    // "assets/images/connect2.png",
                    width: 66.w,
                    height: 66.w,
                  ),
                ),
              ),
              sizedBoxWidth(8.w),
              SizedBox(
                width: 195.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: tittle,
                        // "Roma dsouza",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/call.svg",
                          width: 13.w,
                          height: 13.w,
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: number,
                            // "0225845855",
                            style: TextStyle(
                              color: const Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: SvgPicture.asset(
                            "assets/images/locationconnect.svg",
                            width: 13.w,
                            height: 13.w,
                          ),
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: location,
                            // "Canada",
                            style: TextStyle(
                              color: const Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              // sizedBoxWidth(16.w),

              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                  icon: isConnect == 0
                      // _isChecked
                      ? CircleAvatar(
                          radius: 25.h,
                          backgroundColor: const Color(0XFFF1F1F1),
                          child: const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        )
                      : const Icon(
                          Icons.star_border,
                          color: Color(0XFF707070),
                        ),
                  onPressed: () {
                    ExpertListAPI()
                        .updateMarkExpertApi(expertData[index]['id'])
                        .then((value) {
                      //  expertData[index]["isConnect"] = isConnect == 0 ? 1 : 0;
                      setState(() {});
                    });
                  },
                ),
              ]),

              // SvgPicture.asset(
              //   "assets/images/starconnect.svg",
              //   width: 38.w,
              //   height: 38.w,
              // ),

              // CircleAvatar(
              //   radius: 25.h,
              //   backgroundColor: Color(0XFFF1F1F1),
              //   child: Center(
              //     child: Icon(
              //       Icons.star,
              //       size: 35.h,
              //       color: Color.fromARGB(255, 248, 211, 2),
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 11.h,
          )
        ],
      ),
    );
  }
}

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ThirdTab extends StatelessWidget {
  const ThirdTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
