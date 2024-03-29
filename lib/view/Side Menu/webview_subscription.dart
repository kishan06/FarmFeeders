import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/profile_controller.dart';

class WebViewSubscription extends StatefulWidget {
  WebViewSubscription({super.key, required this.token});
  String token;

  @override
  State<WebViewSubscription> createState() => _WebViewSubscriptionState();
}

class _WebViewSubscriptionState extends State<WebViewSubscription> {
  final GlobalKey webViewKey = GlobalKey();
  String? token;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('accessToken');
    log(prefs.getString('accessToken').toString());
  }

  @override
  void initState() {
    //getData();
    super.initState();
  }

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(
            url: WebUri(
                "https://staging.farmflowsolutions.com/subcription/${profileController.profileInfoModel.value.data!.id}"),
            headers: {
              "Authorization": widget.token,
            }),
        onReceivedError: (controller, request, error) {
          log(error.description);
        },
        onReceivedHttpError: (controller, request, errorResponse) {
          log(errorResponse.data.toString());
        },
      ),
    );
  }
}
