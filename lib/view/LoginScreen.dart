import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

ScrollController? controller;
ScrollController? _scrollviewcontroller;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Color(0xFF0E5F02),
        body: SafeArea(
          child: NestedScrollView(
            controller: _scrollviewcontroller,
            headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
              return <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: 1,
                        (context, index) => Container(
                              height: 300,
                              color: Color(0xFF0E5F02),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Stack(
                                    //  alignment: Alignment.topCenter,
                                    children: [
                                      Positioned(
                                        left: -15 * fem,
                                        top: -15 * fem,
                                        child: SvgPicture.asset(
                                          "assets/grass.svg",
                                        ),
                                      ),
                                      Positioned(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Center(
                                              child: Image.asset(
                                                "assets/logo.png",
                                                height: 200,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))),
              ];
            },
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
