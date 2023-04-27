import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:farmfeeders/view/Notification.dart';
import 'package:farmfeeders/view/Settings.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/ConnectExpert.dart';
import 'package:farmfeeders/view/SplashScreen.dart';
import 'package:farmfeeders/view/Splashslider/SplashSlider.dart';
import 'package:farmfeeders/view/forgot_password.dart';
import 'package:farmfeeders/view/verify_number.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: RouteName.splashslider,
          page: () => const SplashSlider(),
        ),

           GetPage(
          name: RouteName.notification,
          page: () => Notification(),
        ),
           GetPage(
          name: RouteName.settings,
          page: () => Settings(),
        ),
        GetPage(
          name: RouteName.forgotPassword,
          page: () => const ForgotPassword(),
        ),
        GetPage(
          name: RouteName.verifyNumber,
          page: () => const VerifyNumber(),
        ),
        GetPage(
          name: RouteName.connectexperts,
          page: () => ConnectExperts(),
        ),

        

      ];
}
