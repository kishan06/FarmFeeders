import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:farmfeeders/view/Notification.dart';
import 'package:farmfeeders/view/Settings.dart';
import 'package:farmfeeders/view/SplashScreen.dart';
import 'package:farmfeeders/view/Splashslider/SplashSlider.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: RouteName.splashslider,
          page: () => SplashSlider(),
        ),
           GetPage(
          name: RouteName.notification,
          page: () => Notification(),
        ),
           GetPage(
          name: RouteName.settings,
          page: () => Settings(),
        ),
        
      ];
}
