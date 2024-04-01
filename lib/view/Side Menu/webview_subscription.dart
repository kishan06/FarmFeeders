import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

class WebViewSubscription extends StatefulWidget {
  WebViewSubscription({
    super.key,
    required this.token,
    required this.id,
  });
  String token;
  String id;

  @override
  State<WebViewSubscription> createState() => _WebViewSubscriptionState();
}

class _WebViewSubscriptionState extends State<WebViewSubscription> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    //getData();
    super.initState();
  }

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    log("ID ==> ${widget.id}");
    return Scaffold(
      body: InAppWebView(
        key: webViewKey,
        initialUrlRequest: URLRequest(
            url: WebUri(
                "https://staging.farmflowsolutions.com/subcription/${widget.id}"),
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
