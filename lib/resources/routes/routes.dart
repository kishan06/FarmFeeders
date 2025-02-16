import 'package:farmfeeders/Settings.dart';
import 'package:farmfeeders/resources/routes/route_name.dart';
import 'package:farmfeeders/view/Faqs/Accountandappfaq.dart';
import 'package:farmfeeders/view/Faqs/faqs.dart';
import 'package:farmfeeders/view/Home.dart';
import 'package:farmfeeders/view/LiveStockInfoMain.dart';
import 'package:farmfeeders/view/LoginScreen.dart';
import 'package:farmfeeders/view/Notification.dart';
import 'package:farmfeeders/view/NotificationSettings.dart';
import 'package:farmfeeders/view/Profile/personalinfo.dart';
// import 'package:farmfeeders/view/Settings.dart';
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
import 'package:farmfeeders/view/payment_successfull.dart';
import 'package:farmfeeders/view/profile.dart';
import 'package:farmfeeders/view/register.dart';
import 'package:farmfeeders/view/reset_password.dart';
import 'package:farmfeeders/view/verify_number.dart';
import 'package:farmfeeders/view/verify_your_identity.dart';
import 'package:get/get.dart';
import '../../view/Side Menu/NavigateTo pages/subscription_plan.dart';
import '../../view/farmfeedtracker.dart';

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
          name: RouteName.notificationSettings,
          page: () => const NotificationSettings(),
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
          page: () => LetsSetUpYourFarm(
            isInside: false,
            farm: false,
            feed: false,
            livestock: false,
          ),
        ),
        GetPage(
          name: RouteName.farmsInfo,
          page: () => const FarmsInfo(),
        ),
        GetPage(
          name: RouteName.contactus,
          page: () => const ContactUs(),
        ),
        GetPage(
          name: RouteName.liveStockInfoMain,
          page: () => const LiveStockInfoLive(),
        ),
        GetPage(
          name: RouteName.feedtracker,
          page: () => Farmfeedtracker(isInside: false, index: 0),
        ),
        GetPage(
          name: RouteName.home,
          page: () => const Home(),
        ),
        GetPage(
          name: RouteName.sideMenu,
          page: () => const SideMenu(),
        ),
        GetPage(
          name: RouteName.profile,
          page: () => const Profile(),
        ),
        GetPage(
          name: RouteName.personalinfo,
          page: () => const PersonalInfo(),
        ),
        GetPage(
          name: RouteName.manageuser,
          page: () => const manageUser(),
        ),
        GetPage(
          name: RouteName.addSubUser,
          page: () => const addSubUser(),
        ),
        GetPage(
          name: RouteName.newsAndArticleMain,
          page: () => const NewsAndArticleMain(),
        ),
        GetPage(
          name: RouteName.savedArticleMain,
          page: () => const SavedArticleMain(),
        ),
        GetPage(
          name: RouteName.ArticleDetails,
          page: () => const ArticleDetails(),
        ),
        GetPage(
          name: RouteName.TrainingMain,
          page: () => const TrainingMain(),
        ),
        GetPage(
          name: RouteName.VideosList,
          page: () => const VideosList(),
        ),
        GetPage(
          name: RouteName.VideosDetails,
          page: () => const VideosDetails(),
        ),
        GetPage(
          name: RouteName.faqs,
          page: () => const Faq(),
        ),
        GetPage(
          name: RouteName.accountfaq,
          page: () => const Accountapp(),
        ),
        GetPage(
          name: RouteName.yourordermain,
          page: () => const Yourorder(),
        ),
        GetPage(
          name: RouteName.editVideos,
          page: () => const EditVideos(),
        ),
        GetPage(
          name: RouteName.feedBack,
          page: () => const FeedBack(),
        ),
        GetPage(
          name: RouteName.ongoingorder,
          page: () => const Ongoingorder(),
        ),
        GetPage(
          name: RouteName.cancelorder,
          page: () => const Cancelorder(),
        ),
        GetPage(
          name: RouteName.deliveredorder,
          page: () => const Deliveredorder(),
        ),
        GetPage(
          name: RouteName.reorder,
          page: () => const Reorderscreen(
              // onChanged: (value) => 0,
              ),
        ),
        GetPage(
          name: RouteName.connect,
          page: () => const Connectcode(
              // onChanged: (value) => 0,
              ),
        ),
        GetPage(
          name: RouteName.feedbackform,
          page: () => const Feedbackform(
              // onChanged: (value) => 0,
              ),
        ),
        GetPage(
          name: RouteName.settings,
          page: () => const Settings(
              // onChanged: (value) => 0,
              ),
        ),
        GetPage(
          name: RouteName.subscriptionPlan,
          page: () => SubscriptionPlan(
            fromScreen: "",
          ),
        ),
        GetPage(
          name: RouteName.paymentSuccessfull,
          page: () => const PaymentSuccessfull(),
        ),
      ];
}
