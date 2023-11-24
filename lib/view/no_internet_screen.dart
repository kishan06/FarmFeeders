import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoInternetscreen extends StatefulWidget {
  @override
  _NoInternetscreenState createState() => _NoInternetscreenState();
}

class _NoInternetscreenState extends State<NoInternetscreen> {
  Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;
  String? string;
  // @override
  // void initState() {
  //   super.initState();
  //   // timerCheckNetwork();
  //   _connectivity.initialise();
  //   _connectivity.myStream.listen((source) {
  //     setState(() {
  //       _source = source;

  //       switch (_source.keys.toList()[0]) {
  //         case ConnectivityResult.none:
  //           break;
  //         case ConnectivityResult.mobile:
  //           // string = "Mobile: Online";
  //           Navigator.pop(context);
  //           break;
  //         case ConnectivityResult.wifi:
  //           // string = "WiFi: Online";
  //           Navigator.pop(context);
  //           break;
  //       }
  //     });
  //   });
  // }

  // timerCheckNetwork() {
  //   Timer(Duration(seconds: 3), () {
  //     isConnected().then((internet) {
  //       if (internet) {
  //         Navigator.pop(context);
  //         print("Internert 00000");
  //       } else {
  //         print("No Internet");
  //       }
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: Column(children: [
        Center(
          child: Container(
            height: 180.h,
            width: Get.width,
            child: Lottie.asset("assets/lotties/no_internet.json",
                height: 130.h, width: Get.width, fit: BoxFit.cover),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text("Whoops!",
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text("Slow or no internet connection",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 17.0, letterSpacing: 1.0)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text("Please check your internet settings",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontSize: 17.0, letterSpacing: 1.0)),
                  SizedBox(
                    height: 4.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ])),
    );
  }

  // @override
  // void dispose() {
  //   _connectivity.disposeStream();
  //   super.dispose();
  // }
}

// class MyConnectivity {
//   MyConnectivity._internal();

//   static final MyConnectivity _instance = MyConnectivity._internal();

//   static MyConnectivity get instance => _instance;

//   Connectivity connectivity = Connectivity();

//   StreamController controller = StreamController.broadcast();

//   Stream get myStream => controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await connectivity.checkConnectivity();
//     _checkStatus(result);
//     connectivity.onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         isOnline = true;
//       } else
//         isOnline = false;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => controller.close();
// }