import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:farmfeeders/view/SplashScreen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: RouteName.splashScreen,
          page: () => LoginScreen(),
        )
      ];
}
