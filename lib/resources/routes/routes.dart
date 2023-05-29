import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:farmfeeders/view/Faqs/Accountandappfaq.dart';
import 'package:farmfeeders/view/Faqs/faqs.dart';

import 'package:farmfeeders/view/Farmfeedtracker.dart';

import 'package:farmfeeders/view/Home.dart';

import 'package:farmfeeders/view/LiveStockInfoMain.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:farmfeeders/view/Notification.dart';
import 'package:farmfeeders/view/Profile/personalinfo.dart';
import 'package:farmfeeders/view/Settings.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/ConnectExpert.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/ContactUs.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Feedback/feedbackform.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/ArticlesDetails.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/NewsAndArticleMain.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/NewsAndArticle/SavedArticles.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/TrainingMain.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/VideosList.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/Training/videos_details.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/connectcode.dart';

import 'package:farmfeeders/view/Side%20Menu/SideMenu.dart';

import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/addSubUser.dart';
import 'package:farmfeeders/view/Side%20Menu/NavigateTo%20pages/manageUser.dart';

import 'package:farmfeeders/view/SplashScreen.dart';
import 'package:farmfeeders/view/Splashslider/SplashSlider.dart';
import 'package:farmfeeders/view/YourOrder/cancelorder.dart';
import 'package:farmfeeders/view/YourOrder/deliveredorder.dart';
import 'package:farmfeeders/view/YourOrder/ongoingorder.dart';
import 'package:farmfeeders/view/YourOrder/reorder.dart';
import 'package:farmfeeders/view/YourOrder/yourordermain.dart';
import 'package:farmfeeders/view/edit_videos.dart';
import 'package:farmfeeders/view/farmsInfo.dart';
import 'package:farmfeeders/view/feedback.dart';
import 'package:farmfeeders/view/forgot_password.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:farmfeeders/view/profile.dart';

import 'package:farmfeeders/view/register.dart';
import 'package:farmfeeders/view/reset_password.dart';

import 'package:farmfeeders/view/verify_number.dart';
import 'package:farmfeeders/view/verify_your_identity.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
          name: RouteName.register,
          page: () => const Register(),
        ),
        GetPage(
          name: RouteName.splashslider,
          page: () => const SplashSlider(),
        ),
        GetPage(
          name: RouteName.notification,
          page: () => const Notification(),
        ),
        GetPage(
          name: RouteName.settings,
          page: () => const Settings(),
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
          page: () => const ConnectExperts(),
        ),
        GetPage(
          name: RouteName.resetPassword,
          page: () => const ResetPassword(),
        ),
        GetPage(
          name: RouteName.verifyYourIdentity,
          page: () => const VerifyYourIdentity(),
        ),
        GetPage(
          name: RouteName.letsSetUpYourFarm,
          page: () => const LetsSetUpYourFarm(),
        ),
        GetPage(
          name: RouteName.farmsInfo,
          page: () => const FarmsInfo(),
        ),
        GetPage(
          name: RouteName.contactus,
          page: () => ContactUs(),
        ),
        GetPage(
          name: RouteName.liveStockInfoMain,
          page: () => LiveStockInfoLive(),
        ),
        GetPage(
          name: RouteName.feedtracker,
          page: () => Farmfeedtracker(),
        ),
        GetPage(
          name: RouteName.home,
          page: () => Home(),
        ),
        GetPage(
          name: RouteName.sideMenu,
          page: () => SideMenu(),

          ),
    
        GetPage(
          name: RouteName.profile,
          page: () => Profile(),
        ),
        GetPage(
          name: RouteName.personalinfo,
          page: () => PersonalInfo(),
        ),
        GetPage(
          name: RouteName.manageuser,
          page: () => manageUser(),
        ),
        GetPage(
          name: RouteName.addSubUser,
          page: () => addSubUser(),
        ),
        GetPage(
          name: RouteName.newsAndArticleMain,
          page: () => NewsAndArticleMain(),
        ),
        GetPage(
          name: RouteName.savedArticleMain,
          page: () => SavedArticleMain(),
        ),
        GetPage(
          name: RouteName.ArticleDetails,
          page: () => ArticleDetails(),
        ),
        GetPage(
          name: RouteName.TrainingMain,
          page: () => TrainingMain(),
        ),
        GetPage(
          name: RouteName.VideosList,
          page: () => VideosList(),
        ),
        GetPage(
          name: RouteName.VideosDetails,
          page: () => VideosDetails(),
        ),
        GetPage(
          name: RouteName.faqs,
          page: () => Faq(),
        ),
        GetPage(
          name: RouteName.accountfaq,
          page: () => Accountapp(),
        ),
        GetPage(
          name: RouteName.yourordermain,
          page: () => Yourorder(),
        ),

        GetPage(
          name: RouteName.editVideos,
          page: () => EditVideos(),
        ),

        GetPage(
          name: RouteName.feedBack,
          page: () => FeedBack(),
        ),


         GetPage(
          name: RouteName.ongoingorder,
          page: () => Ongoingorder(),
        ),

        GetPage(
          name: RouteName.cancelorder,
          page: () => Cancelorder(),
        ),

        GetPage(
          name: RouteName.deliveredorder,
          page: () => Deliveredorder(),
        ),

        GetPage(
          name: RouteName.reorder,
          page: () =>Reorderscreen(
            // onChanged: (value) => 0,
            ),
        ),


         GetPage(
          name: RouteName.connect,
          page: () =>Connectcode(
            // onChanged: (value) => 0,
            ),
        ),

         GetPage(
          name: RouteName.feedbackform,
          page: () =>Feedbackform(
            // onChanged: (value) => 0,
            ),
        ),
        

      ];
}
