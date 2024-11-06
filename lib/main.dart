import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/global.dart';
import 'package:farmfeeders/firebase_options.dart';
import 'package:farmfeeders/resources/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.initialize("19cd37f3-7bd7-4b1d-8c59-b3cce2386c9e");
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  // Stripe.publishableKey =
  //     "pk_test_51NleA3BYVJTtq48mzSztnR76rUC9ZIRjZ4a4jEdz6V3D4Zd1utMCe0xMRYJuRnzlF5UKfLIsrNKtFrdI6CFZn7Xm007zmh2SfP";
  // "pk_test_51NmWnhSHA3cTuLkgr4SJbN7PN2Uz3sPLj1TzDbCoMpjBvNlXROsnnJoQjsqlcJEht8VzYLCfmqrpqsfk9iJ2Rsgg00bVMCbQRj";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // GlobalVariables globalVariables = GlobalVariables();
  token = prefs.getString('accessToken');

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
    
  };
  // log(token!);
  await dotenv.load(fileName: ".env");
  

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
    // subscription =
    //     connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    //   if (result == ConnectivityResult.wifi ||
    //       result == ConnectivityResult.mobile) {
    //     setState(() {
    //       Get.back();
    //     });
    //   } else {
    //     setState(() {
    //       Get.to(() => const NoInternetscreen());
    //     });
    //   }
    // });
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
            title: 'FarmFlow Farmer',
            theme: ThemeData(
              fontFamily: "Poppins",
              scaffoldBackgroundColor: AppColors.white,
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            getPages: AppRoutes.appRoutes(),
          );
        });
  }
}
