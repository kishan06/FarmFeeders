import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key});

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  final tecComment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(86),
                child: Material(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14)),
                  // shape: Border.all(color: Colors.white),
                  color: Colors.white,
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    height: 86.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 21,
                          child: Text(
                            "ABC",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'StudioProM',
                                color: const Color(0xff141414)),
                          ),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text(
                          'ABCIreland',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff141414)),
                        ),
                        Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF0E5F02),
                          size: 24,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        opacity: 1,
                        image: AssetImage('assets/images/newsDetail.png'),
                      ),
                    ),

                    // child: Image.asset(
                    //   "assets/Mask Group 108.png",
                    //   // color: Color.fromARGB(255, 168, 168, 168).withOpacity(0.54),
                    // ),
                  ),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  // Get.toNamed("/newsandarticlemain");
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.black,
                                    ),
                                  ),
                                  radius: 15.r,
                                ),
                              ),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor:
                                    Colors.transparent.withOpacity(0.28),
                                child: Center(
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                                radius: 15.r,
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 28.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFF80B918),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    "Feed",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Lorem Ipsum Is Simply Dummy Of The Printing And",
                            style: TextStyle(
                                color: Color(0xFFEEEEEE),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Text(
                                "Trending",
                                style: TextStyle(
                                    color: Color(0xFFEEEEEE),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "•",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                              ),
                              Text(
                                "6 Hours ago",
                                style: TextStyle(
                                    color: Color(0xFFEEEEEE),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              expandedHeight: 363,
              backgroundColor: Colors.white,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (context, index) => SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    width: double.infinity,
                    // width: 20,
                    // height: 600,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Divider(
                          //     // color: const Color(0xff00000029),
                          //     ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              '''lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. it has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. it was popularised in the 1960s with the release of letraset sheets containing lorem ipsu m passages,lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. it has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. it was popularised in the 1960s with the release of letraset sheets containing lorem ipsu m passages,lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. it has ''',
                              style: TextStyle(
                                  color: const Color(0xff4D4D4D),
                                  fontSize: 16.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
