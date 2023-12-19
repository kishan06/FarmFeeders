import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/resources/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/no_internet_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51NleA3BYVJTtq48mzSztnR76rUC9ZIRjZ4a4jEdz6V3D4Zd1utMCe0xMRYJuRnzlF5UKfLIsrNKtFrdI6CFZn7Xm007zmh2SfP";
  // "pk_test_51NmWnhSHA3cTuLkgr4SJbN7PN2Uz3sPLj1TzDbCoMpjBvNlXROsnnJoQjsqlcJEht8VzYLCfmqrpqsfk9iJ2Rsgg00bVMCbQRj";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // GlobalVariables globalVariables = GlobalVariables();
  token = prefs.getString('accessToken');
  // log(token!);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> subscription;
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {
          Get.back();
        });
      } else {
        setState(() {
          Get.to(NoInternetscreen());
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: "Poppins",
              scaffoldBackgroundColor: AppColors.white,
              primarySwatch: Colors.blue,
            ),

            initialRoute: '/',
            //  initialRoute: '/paymentSuccessfull',
            // home: BasicSubscriptionPlan(),
            //  initialRoute: StripePayment(context),

            getPages: AppRoutes.appRoutes(),
          );
        });
  }
}
