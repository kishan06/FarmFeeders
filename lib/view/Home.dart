import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:farmfeeders/Utils/api_urls.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/dashboard_controller.dart';
import 'package:farmfeeders/controller/notification_controller.dart';
import 'package:farmfeeders/controller/profile_controller.dart';
import 'package:farmfeeders/models/NotificationModel/notification_count_model.dart';
import 'package:farmfeeders/models/connection_code_model.dart';
import 'package:farmfeeders/view/lets_set_up_your_farm.dart';
import 'package:farmfeeders/view/weather/weather_forecast.dart';
import 'package:farmfeeders/view_models/ConnectionCodeApi.dart';
import 'package:farmfeeders/view_models/DashboardApi.dart';
import 'package:farmfeeders/view_models/NotificationAPI.dart';
import 'package:farmfeeders/view_models/WeatherApi.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as ls;
import 'package:geolocator/geolocator.dart';
import 'package:farmfeeders/common/custom_button_curve.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/custom_dropdown.dart';
import '../common/status.dart';
import '../models/dashboardModel.dart';
import '../view_models/SetupFarmInfoAPI.dart';
import 'farmfeedtracker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool lowFeed = true;
  bool saved = false;
  final location = ls.Location();
  String? selectedLocation, currentLocationName;
  List<String> locationName = [];
  List<LatLng> locationLatLng = [];
  DashboardController dashboardController = Get.put(DashboardController());
  ProfileController profileController = Get.put(ProfileController());
  NotificationController notificationController =
      Get.put(NotificationController());

  List currentFeedData = [
    {"imagePath": "assets/images/buffalo.png", "feedFor": "Beef", "qty": "100"},
    {"imagePath": "assets/images/cow.png", "feedFor": "Cow", "qty": "600"},
    {"imagePath": "assets/images/sheep.png", "feedFor": "Sheep", "qty": "100"},
    {"imagePath": "assets/images/pig.png", "feedFor": "Pigs", "qty": "600"},
    {"imagePath": "assets/images/hen.png", "feedFor": "Hen", "qty": "100"},
  ];

  int selectedCurrentFeed = 0;
  Stream<DateTime>? _clockStream;
  String? place = "Unknown",
      temperature = "00.0",
      humidity = "0",
      wind = "00.0",
      weatherCondition = "";
  RxDouble feedPerValue = 101.0.obs;

  bool isDaytimeNow(
      DateTime currentTime, DateTime sunriseTime, DateTime sunsetTime) {
    return currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime);
  }

  accessDeniedDialog(context, text) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/delete.png",
                    width: 80.w,
                    height: 80.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      //fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XFF0E5F02)),
                        borderRadius: BorderRadius.circular(10.h),
                        color: AppColors.buttoncolour),
                    child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    dashboardController.isWeatherLoading.value = true;
    dashboardController.isDashboardApiLoading.value = true;
    _clockStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ConnectionCodeApi().getConnectionCode().then((value) {
        ConnectionCodeModel codeModel =
            ConnectionCodeModel.fromJson(value.data);
        dashboardController.connectionCodeValue = codeModel.data!.connectCode!;
      });
      NotificationAPI().getNotificationCount().then((value) {
        NotificationCountModel notificationCountModel =
            NotificationCountModel.fromJson(value.data);
        notificationController.notificationCount.value =
            notificationCountModel.data.toString();
        //     getCurrentAddress();
      });
      DashboardApi().getDashboardData().then((value) async {
        dashboardController.dashboardModel =
            DashboardModel.fromJson(value.data);
        if (dashboardController
                .dashboardModel.data!.profileCompletionPercentage! <
            100) {
          Get.off(LetsSetUpYourFarm(
            isInside: true,
            farm: dashboardController.dashboardModel.data!.dataFilled!.farm!,
            feed: dashboardController.dashboardModel.data!.dataFilled!.feed!,
            livestock:
                dashboardController.dashboardModel.data!.dataFilled!.livestock!,
          ));
        }
        for (var i in dashboardController.dashboardModel.data!.currentFeed!) {
          if (i.feedLow!) {
            if (feedPerValue > i.feedLowPer!) {
              feedPerValue.value = i.feedLowPer!;
            }
          }
        }
        if (dashboardController.dashboardModel.data!.article != null) {
          saved = dashboardController.dashboardModel.data!.article!.bookmarked!;
        }
        dashboardController.isDashboardApiLoading.value = false;
        await getCurrentAddress();
        final permissionGranted = await location.hasPermission();
        if (permissionGranted == ls.PermissionStatus.granted) {
          currentLocationName = await getAddressFromLatLng(
              dashboardController.currentLat!, dashboardController.currentLng!);
          locationLatLng.add(LatLng(dashboardController.currentLat!,
              dashboardController.currentLng!));
          locationName.add(await getAddressFromLatLng(
              dashboardController.currentLat!,
              dashboardController.currentLng!));
        }
        for (var i
            in dashboardController.dashboardModel.data!.primaryFarmLocation!) {
          locationLatLng.add(LatLng(
              double.parse(i.farmLatitude!), double.parse(i.farmLongitude!)));
          locationName.add(await getAddressFromLatLng(
              double.parse(i.farmLatitude!), double.parse(i.farmLongitude!)));
        }

        dashboardController.isWeatherLoading.value = false;
      });
    });

    super.initState();
  }

  Future<void> getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    temperature = prefs.getString('temperature') == null
        ? "00.0"
        : prefs.getString('temperature') ?? "00.0";
    place = prefs.getString('location') == null
        ? "Unknown"
        : prefs.getString('location') ?? "Unknown";
    wind = prefs.getString('wind') == null
        ? "00.0"
        : prefs.getString('wind') ?? "00.0";
    humidity = prefs.getString('humidity') == null
        ? "0"
        : prefs.getString('humidity') ?? "0";
    weatherCondition = prefs.getString('weatherCondition') == null
        ? ""
        : prefs.getString('weatherCondition') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    DateTime sunrise = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 6, 30); // Example: 6:30 AM
    DateTime sunset = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, 19, 00); // Example: 6:30 PM

    // Get the current time
    DateTime currentTime = DateTime.now();
    bool isDaytime = isDaytimeNow(currentTime, sunrise, sunset);

    return Scaffold(
        // appBar: AppBar(
        //   title: customAppBarHome(text: "knc"),
        //   backgroundColor: Colors.white,
        //   automaticallyImplyLeading: false,
        //   elevation: 0,
        //   titleSpacing: 0,
        // ),
        body: RefreshIndicator(
      strokeWidth: 3,
      displacement: 250,
      backgroundColor: Colors.white,
      color: AppColors.buttoncolour,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));

        NotificationAPI().getNotificationCount().then((value) {
          NotificationCountModel notificationCountModel =
              NotificationCountModel.fromJson(value.data);
          notificationController.notificationCount.value =
              notificationCountModel.data.toString();
          //     getCurrentAddress();
        });
        DashboardApi().getDashboardData().then((value) async {
          dashboardController.dashboardModel =
              DashboardModel.fromJson(value.data);

          for (var i in dashboardController.dashboardModel.data!.currentFeed!) {
            if (i.feedLow!) {
              if (feedPerValue > i.feedLowPer!) {
                feedPerValue.value = i.feedLowPer!;
              }
            }
          }
          if (dashboardController.dashboardModel.data!.article != null) {
            saved =
                dashboardController.dashboardModel.data!.article!.bookmarked!;
          }
          //  dashboardController.isDashboardApiLoading.value = false;
          //   await getCurrentAddress();
          // final permissionGranted = await location.hasPermission();
          // if (permissionGranted == ls.PermissionStatus.granted) {
          //   currentLocationName =
          //       await getAddressFromLatLng(currentLat!, currentLng!);
          //   locationLatLng.add(LatLng(currentLat!, currentLng!));
          //   locationName
          //       .add(await getAddressFromLatLng(currentLat!, currentLng!));
          // }
          // for (var i in dashboardController
          //     .dashboardModel.data!.primaryFarmLocation!) {
          //   locationLatLng.add(LatLng(
          //       double.parse(i.farmLatitude!), double.parse(i.farmLongitude!)));
          //   locationName.add(await getAddressFromLatLng(
          //       double.parse(i.farmLatitude!), double.parse(i.farmLongitude!)));
          // }

          // dashboardController.isWeatherLoading.value = false;
        });
        setState(() {});
      },
      child: SafeArea(
        child: Obx(
          () => dashboardController.isDashboardApiLoading.value
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 75,
                        ),
                        SizedBox(
                          width: Get.width,
                          height: 500,
                          child: Shimmer.fromColors(
                              baseColor: AppColors.pistaE3FFE9,
                              highlightColor: AppColors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.pistaE3FFE9,
                                ),
                              )),
                        ),
                        sizedBoxHeight(10.h),
                        SizedBox(
                          width: Get.width,
                          height: 500,
                          child: Shimmer.fromColors(
                              baseColor: AppColors.pistaE3FFE9,
                              highlightColor: AppColors.pistaE3FFE9,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(27.h),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                  ],
                                  color: AppColors.pistaE3FFE9,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(75.w, 10.h, 16.w, 10.h),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textBlack20W7000Mon("Welcome Back"),
                              Text(
                                dashboardController
                                    .dashboardModel.data!.userName!,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Stack(
                            children: [
                              Container(
                                height: 42.h,
                                width: 45.h,
                              ),
                              Container(
                                height: 42.h,
                                width: 42.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade400,
                                      blurRadius: 5.h,
                                      spreadRadius: 2.h,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed("/notification");
                                      },
                                      child: SvgPicture.asset(
                                        "assets/images/notification_bell.svg",
                                        height: 28.h,
                                        width: 28.h,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              notificationController.notificationCount.value ==
                                      "0"
                                  ? const SizedBox()
                                  : Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4.0),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          notificationController
                                              .notificationCount.value,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          sizedBoxWidth(10.w),
                          Container(
                            height: 42.h,
                            width: 42.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.h),
                              color: AppColors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 5.h,
                                  spreadRadius: 2.h,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.settings,
                                //   size: 3.h,
                                //   // color: app,
                                // )
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/settings");
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/Settings.svg",
                                    height: 28.h,
                                    width: 28.h,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27.h),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        )
                                      ],
                                      color: AppColors.pistaE3FFE9,
                                    ),
                                    child: Column(
                                      children: [
                                        dashboardController
                                                .isWeatherLoading.value
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 25,
                                                    bottom: 15,
                                                  ),
                                                  child: Text(
                                                    "Hold tight while we check the skies for your weather details!",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      const WeatherForecastScreen());
                                                },
                                                child: Stack(
                                                  children: [
                                                    Obx(
                                                      () => Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: (dashboardController
                                                                          .weatherCondition
                                                                          .value ==
                                                                      "Sunny" ||
                                                                  dashboardController
                                                                          .weatherCondition
                                                                          .value ==
                                                                      "Clear")
                                                              ? isDaytime
                                                                  ? Lottie
                                                                      .asset(
                                                                      "assets/lotties/sun_animation.json",
                                                                      height:
                                                                          240.h,
                                                                      width:
                                                                          240.w,
                                                                    )
                                                                  : Lottie
                                                                      .asset(
                                                                      "assets/lotties/moon_animation.json",
                                                                      height:
                                                                          175.h,
                                                                      width:
                                                                          175.w,
                                                                    )
                                                              : (dashboardController
                                                                          .weatherCondition
                                                                          .value ==
                                                                      "Partly cloudy")
                                                                  ? isDaytime
                                                                      ? Lottie
                                                                          .asset(
                                                                          "assets/lotties/sun_with_cloud_animation.json",
                                                                          height:
                                                                              240.h,
                                                                          width:
                                                                              240.w,
                                                                        )
                                                                      : Lottie
                                                                          .asset(
                                                                          "assets/lotties/moon_with_cloud_animation.json",
                                                                          height:
                                                                              240.h,
                                                                          width:
                                                                              240.w,
                                                                        )
                                                                  : (dashboardController.weatherCondition.value ==
                                                                              "Cloudy" ||
                                                                          dashboardController.weatherCondition.value ==
                                                                              "Overcast")
                                                                      ? Lottie
                                                                          .asset(
                                                                          "assets/lotties/clouds.json",
                                                                          height:
                                                                              240.h,
                                                                          width:
                                                                              240.w,
                                                                        )
                                                                      : (dashboardController.weatherCondition.value == "Mist" ||
                                                                              dashboardController.weatherCondition.value == "Fog" ||
                                                                              dashboardController.weatherCondition.value == "Freezing fog")
                                                                          ? Lottie.asset(
                                                                              "assets/lotties/cloud2.json",
                                                                              height: 240.h,
                                                                              width: 240.w,
                                                                            )
                                                                          : (dashboardController.weatherCondition.value == "Patchy rain possible" || dashboardController.weatherCondition.value == "Patchy freezing drizzle possible" || dashboardController.weatherCondition.value == "Thundery outbreaks possible" || dashboardController.weatherCondition.value == "Patchy light drizzle" || dashboardController.weatherCondition.value == "Light drizzle" || dashboardController.weatherCondition.value == "Freezing drizzle" || dashboardController.weatherCondition.value == "Heavy freezing drizzle " || dashboardController.weatherCondition.value == "Patchy light rain" || dashboardController.weatherCondition.value == "Light rain" || dashboardController.weatherCondition.value == "Moderate rain at times" || dashboardController.weatherCondition.value == "Moderate rain" || dashboardController.weatherCondition.value == "Heavy rain at times" || dashboardController.weatherCondition.value == "Heavy rain" || dashboardController.weatherCondition.value == "Light freezing rain" || dashboardController.weatherCondition.value == "Moderate or heavy freezing rain" || dashboardController.weatherCondition.value == "Torrential rain shower" || dashboardController.weatherCondition.value == "Light sleet showers" || dashboardController.weatherCondition.value == "Patchy light rain with thunder" || dashboardController.weatherCondition.value == "Moderate or heavy rain with thunder")
                                                                              ? Lottie.asset(
                                                                                  "assets/lotties/cloud_with_rain_animation.json",
                                                                                  height: 240.h,
                                                                                  width: 240.w,
                                                                                )
                                                                              : (dashboardController.weatherCondition.value == "Patchy snow possible" || dashboardController.weatherCondition.value == "Patchy sleet possible" || dashboardController.weatherCondition.value == "Light sleet" || dashboardController.weatherCondition.value == "Moderate or heavy sleet" || dashboardController.weatherCondition.value == "Patchy light snow" || dashboardController.weatherCondition.value == "Light snow" || dashboardController.weatherCondition.value == "Patchy moderate snow" || dashboardController.weatherCondition.value == "Moderate snow" || dashboardController.weatherCondition.value == "Patchy heavy snow" || dashboardController.weatherCondition.value == "Heavy snow" || dashboardController.weatherCondition.value == "Ice pellets" || dashboardController.weatherCondition.value == "Moderate or heavy sleet showers" || dashboardController.weatherCondition.value == "Light snow showers" || dashboardController.weatherCondition.value == "Moderate or heavy snow showers" || dashboardController.weatherCondition.value == "Light showers of ice pellets" || dashboardController.weatherCondition.value == "Moderate or heavy showers of ice pellets")
                                                                                  ? Lottie.asset(
                                                                                      "assets/lotties/snow_animation.json",
                                                                                      height: 240.h,
                                                                                      width: 240.w,
                                                                                    )
                                                                                  : (dashboardController.weatherCondition.value == "Blowing snow" || dashboardController.weatherCondition.value == "Blizzard" || dashboardController.weatherCondition.value == "Patchy light snow with thunder" || dashboardController.weatherCondition.value == "Moderate or heavy snow with thunder")
                                                                                      ? Lottie.asset(
                                                                                          "assets/lotties/snow_animation.json",
                                                                                          height: 240.h,
                                                                                          width: 240.w,
                                                                                        )
                                                                                      : Lottie.asset(
                                                                                          "assets/lotties/cloud2.json",
                                                                                          height: 240.h,
                                                                                          width: 240.w,
                                                                                        )),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              36.w,
                                                              25.h,
                                                              36.w,
                                                              12.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Stack(
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SvgPicture
                                                                              .asset(
                                                                            "assets/images/locationconnect.svg",
                                                                            color:
                                                                                AppColors.black,
                                                                            height:
                                                                                20.h,
                                                                            width:
                                                                                20.h,
                                                                          ),

                                                                          // textBlack20W7000("Ireland"),
                                                                          SizedBox(
                                                                            width:
                                                                                180.w,
                                                                            child:
                                                                                DropdownBtn(
                                                                              bgColor: AppColors.pistaE3FFE9,
                                                                              hint: dashboardController.currentLat != 0 ? currentLocationName! : locationName[0],
                                                                              // items: ,
                                                                              items: locationName
                                                                                  .map((e) => DropdownMenuItem(
                                                                                        value: e,
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            selectedLocation = e;

                                                                                            getCurrentWeatherData(
                                                                                              locationLatLng[locationName.indexOf(e)].latitude,
                                                                                              locationLatLng[locationName.indexOf(e)].longitude,
                                                                                            );
                                                                                          });
                                                                                        },
                                                                                        child: Text(
                                                                                          e,
                                                                                          style: const TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight.bold,
                                                                                            color: Color(0xFF4D4D4D),
                                                                                          ),
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                      ))
                                                                                  .toList(),
                                                                              value: selectedLocation,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Obx(
                                                                        () => textGreen50Bold(
                                                                            "${dashboardController.isLocationFetching.value ? temperature! : dashboardController.tempValue.value}° C"),
                                                                      ),
                                                                      Obx(() =>
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              rowWithText("assets/images/humidity.png", humidity!, dashboardController.humidityValue.value),
                                                                              rowWithText("assets/images/wind.png", "${wind!} kph", "${dashboardController.windValue.value} kph"),
                                                                            ],
                                                                          )),
                                                                      StreamBuilder<
                                                                          DateTime>(
                                                                        stream:
                                                                            _clockStream,
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            String
                                                                                formattedDateTime =
                                                                                DateFormat('E, d MMM - hh:mm a').format(snapshot.data!);

                                                                            return Center(
                                                                              child: textBlack18W5000(
                                                                                formattedDateTime,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return textBlack18W5000('Loading...');
                                                                          }
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        (dashboardController.dashboardModel
                                                        .data!.order !=
                                                    null &&
                                                dashboardController
                                                        .dashboardModel
                                                        .data!
                                                        .order!
                                                        .product !=
                                                    null)
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/ongoingorder",
                                                      arguments: {
                                                        "id": dashboardController
                                                            .dashboardModel
                                                            .data!
                                                            .order!
                                                            .orderHeaderXid!,
                                                      });
                                                },
                                                child: Container(
                                                  height: 230.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          color:
                                                              AppColors.white,
                                                          boxShadow: [
                                                        BoxShadow(
                                                            color: Color(
                                                                0x48B9B9BE),
                                                            blurRadius: 8.0,
                                                            spreadRadius: 0)
                                                      ]),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 18.w,
                                                                  top: 12.h,
                                                                  bottom: 28.h),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 30.h,
                                                                width: 123.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25.h),
                                                                  color: const Color(
                                                                      0XFFFFB7B7),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "Arriving Soon",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16.sp,
                                                                      color: const Color(
                                                                          0XFFAC2A33),
                                                                      fontFamily:
                                                                          "Poppins",
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              sizedBoxHeight(
                                                                  15.h),
                                                              Image.network(
                                                                "${ApiUrls.baseImageUrl}/${dashboardController.dashboardModel.data!.order!.product!.smallImageUrl}",
                                                                width: 105.w,
                                                                height: 98.h,
                                                              ),
                                                              //  sizedBoxHeight(7.h),
                                                              Text(
                                                                dashboardController
                                                                    .dashboardModel
                                                                    .data!
                                                                    .order!
                                                                    .product!
                                                                    .title!,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13.sp,
                                                                    color: const Color(
                                                                        0XFF141414)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 19.h),
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  status(),
                                                                  const DottedLine(
                                                                    direction: Axis
                                                                        .vertical,
                                                                    lineLength:
                                                                        30,
                                                                    lineThickness:
                                                                        2.0,
                                                                    dashLength:
                                                                        4.0,
                                                                    dashColor:
                                                                        Color(
                                                                            0XFF0E5F02),
                                                                  ),
                                                                  dashboardController
                                                                          .dashboardModel
                                                                          .data!
                                                                          .order!
                                                                          .orderStatus!
                                                                          .any((item) =>
                                                                              item.deliveryStatusXid ==
                                                                              4)
                                                                      ? status()
                                                                      : (dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 3) ||
                                                                              dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 1))
                                                                          ? CircleAvatar(
                                                                              backgroundColor: AppColors.buttoncolour,
                                                                              radius: 11.w,
                                                                              child: CircleAvatar(
                                                                                radius: 9.w,
                                                                                backgroundColor: AppColors.pistaE3FFE9,
                                                                                child: SvgPicture.asset("assets/images/delivery.svg"),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              width: 15,
                                                                              height: 15,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white, border: Border.all(color: AppColors.buttoncolour)),
                                                                            ),
                                                                  const DottedLine(
                                                                    direction: Axis
                                                                        .vertical,
                                                                    lineLength:
                                                                        30,
                                                                    lineThickness:
                                                                        2.0,
                                                                    dashLength:
                                                                        4.0,
                                                                    dashColor:
                                                                        Color(
                                                                            0XFF0E5F02),
                                                                  ),
                                                                  dashboardController
                                                                          .dashboardModel
                                                                          .data!
                                                                          .order!
                                                                          .orderStatus!
                                                                          .any((item) =>
                                                                              item.deliveryStatusXid ==
                                                                              5)
                                                                      ? status()
                                                                      : dashboardController
                                                                              .dashboardModel
                                                                              .data!
                                                                              .order!
                                                                              .orderStatus!
                                                                              .any((item) => item.deliveryStatusXid == 4)
                                                                          ? CircleAvatar(
                                                                              backgroundColor: AppColors.buttoncolour,
                                                                              radius: 11.w,
                                                                              child: CircleAvatar(
                                                                                radius: 9.w,
                                                                                backgroundColor: AppColors.pistaE3FFE9,
                                                                                child: SvgPicture.asset("assets/images/delivery.svg"),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              width: 15,
                                                                              height: 15,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white, border: Border.all(color: AppColors.buttoncolour)),
                                                                            ),
                                                                  const DottedLine(
                                                                    direction: Axis
                                                                        .vertical,
                                                                    lineLength:
                                                                        30,
                                                                    lineThickness:
                                                                        2.0,
                                                                    dashLength:
                                                                        4.0,
                                                                    dashColor:
                                                                        Color(
                                                                            0XFF0E5F02),
                                                                  ),
                                                                  dashboardController
                                                                          .dashboardModel
                                                                          .data!
                                                                          .order!
                                                                          .orderStatus!
                                                                          .any((item) =>
                                                                              item.deliveryStatusXid ==
                                                                              7)
                                                                      ? status()
                                                                      : (dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 5) ||
                                                                              dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 6))
                                                                          ? CircleAvatar(
                                                                              backgroundColor: AppColors.buttoncolour,
                                                                              radius: 11.w,
                                                                              child: CircleAvatar(
                                                                                radius: 9.w,
                                                                                backgroundColor: AppColors.pistaE3FFE9,
                                                                                child: SvgPicture.asset("assets/images/delivery.svg"),
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              width: 15,
                                                                              height: 15,
                                                                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white, border: Border.all(color: AppColors.buttoncolour)),
                                                                            ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Ordered",
                                                                    style: TextStyle(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: const Color(
                                                                            0XFF0E5F02),
                                                                        fontFamily:
                                                                            "Poppins"),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SvgPicture
                                                                          .asset(
                                                                        "assets/images/clock-svgrepo-com (1).svg",
                                                                        width:
                                                                            6.w,
                                                                        height:
                                                                            6.w,
                                                                      ),
                                                                      sizedBoxWidth(
                                                                          6.w),
                                                                      Text(
                                                                        Utils.convertUtcToCustomFormat(dashboardController
                                                                            .dashboardModel
                                                                            .data!
                                                                            .order!
                                                                            .orderDate!),
                                                                        style: TextStyle(
                                                                            color:
                                                                                const Color(0xff4D4D4D),
                                                                            fontSize: 8.sp,
                                                                            fontFamily: "Poppins"),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  sizedBoxHeight(
                                                                      14.h),
                                                                  Container(
                                                                    height:
                                                                        30.h,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25.h),
                                                                      color: (dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 3) &&
                                                                              dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) =>
                                                                                  item.deliveryStatusXid !=
                                                                                  4))
                                                                          ? Colors
                                                                              .transparent
                                                                          : const Color(
                                                                              0XFFF1F1F1),
                                                                    ),
                                                                    child: Text(
                                                                      "Packed and ready",
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color: dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 4)
                                                                              ? const Color(0XFF0E5F02)
                                                                              : const Color(0XFF4D4D4D),
                                                                          fontFamily: "Poppins"),
                                                                    ),
                                                                  ),
                                                                  dashboardController
                                                                          .dashboardModel
                                                                          .data!
                                                                          .order!
                                                                          .orderStatus!
                                                                          .any((item) =>
                                                                              item.deliveryStatusXid ==
                                                                              4)
                                                                      ? Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            SvgPicture.asset(
                                                                              "assets/images/clock-svgrepo-com (1).svg",
                                                                              width: 6.w,
                                                                              height: 6.w,
                                                                            ),
                                                                            sizedBoxWidth(6.w),
                                                                            Text(
                                                                              Utils.convertUtcToCustomFormat(dashboardController.dashboardModel.data!.order!.orderStatus![3].createdAt!),
                                                                              style: TextStyle(color: const Color(0xff4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
                                                                            )
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                                                  sizedBoxHeight(
                                                                      19.h),
                                                                  Container(
                                                                    height:
                                                                        30.h,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25.h),
                                                                      color: !(dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 4) &&
                                                                              dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) =>
                                                                                  item.deliveryStatusXid !=
                                                                                  5))
                                                                          ? Colors
                                                                              .transparent
                                                                          : const Color(
                                                                              0XFFF1F1F1),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Out for delivery",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          color: dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 5)
                                                                              ? const Color(0XFF0E5F02)
                                                                              : const Color(0XFF4D4D4D),
                                                                          fontFamily:
                                                                              "Poppins",
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  dashboardController
                                                                          .dashboardModel
                                                                          .data!
                                                                          .order!
                                                                          .orderStatus!
                                                                          .any((item) =>
                                                                              item.deliveryStatusXid ==
                                                                              5)
                                                                      ? Row(
                                                                          children: [
                                                                            SvgPicture.asset(
                                                                              "assets/images/clock-svgrepo-com (1).svg",
                                                                              width: 6.w,
                                                                              height: 6.w,
                                                                            ),
                                                                            sizedBoxWidth(6.w),
                                                                            Text(
                                                                              Utils.convertUtcToCustomFormat(dashboardController.dashboardModel.data!.order!.orderStatus![3].createdAt!),
                                                                              style: TextStyle(color: const Color(0xff4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : const SizedBox(),
                                                                  sizedBoxHeight(
                                                                      15.h),
                                                                  Container(
                                                                    height:
                                                                        30.h,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              25.h),
                                                                      color: !((dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 5) || dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 6)) &&
                                                                              dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) =>
                                                                                  item.deliveryStatusXid !=
                                                                                  7))
                                                                          ? Colors
                                                                              .transparent
                                                                          : const Color(
                                                                              0XFFF1F1F1),
                                                                    ),
                                                                    child: Text(
                                                                      "Delivered",
                                                                      style: TextStyle(
                                                                          fontSize: 14
                                                                              .sp,
                                                                          color: const Color(
                                                                              0XFF4D4D4D),
                                                                          fontFamily:
                                                                              "Poppins"),
                                                                    ),
                                                                  ),
                                                                  dashboardController
                                                                          .dashboardModel
                                                                          .data!
                                                                          .order!
                                                                          .orderStatus!
                                                                          .any((item) =>
                                                                              item.deliveryStatusXid ==
                                                                              7)
                                                                      ? Row(
                                                                          children: [
                                                                            SvgPicture.asset(
                                                                              "assets/images/clock-svgrepo-com (1).svg",
                                                                              width: 6.w,
                                                                              height: 6.w,
                                                                            ),
                                                                            sizedBoxWidth(6.w),
                                                                            Text(
                                                                              Utils.convertUtcToCustomFormat(dashboardController.dashboardModel.data!.order!.orderStatus![5].createdAt!),
                                                                              style: TextStyle(color: dashboardController.dashboardModel.data!.order!.orderStatus!.any((item) => item.deliveryStatusXid == 7) ? const Color(0XFF0E5F02) : const Color(0XFF4D4D4D), fontSize: 8.sp, fontFamily: "Poppins"),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : const SizedBox()
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w,
                                                    vertical: 10.h),
                                                child: Container(
                                                  height: 200.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  19.h)),
                                                      color: AppColors.white,
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color:
                                                              Color(0x48B9B9BE),
                                                          blurRadius: 10,
                                                          spreadRadius: 2,
                                                        )
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 24.w,
                                                            vertical: 15.h),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            textBlack20W7000(
                                                                "No ongoing order's right now"),
                                                            Lottie.asset(
                                                                "assets/lotties/delivery_track.json",
                                                                height: 50.h,
                                                                width: 130.w,
                                                                fit: BoxFit
                                                                    .cover)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  sizedBoxHeight(10.h),
                                  dashboardController.dashboardModel.data!
                                          .currentFeed!.isEmpty
                                      ? const SizedBox()
                                      : Stack(
                                          // fit: StackFit.loose,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(27.h),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.04),
                                                    blurRadius: 10,
                                                    spreadRadius: 2,
                                                  )
                                                ],
                                                color: AppColors.pistaE3FFE9,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 15.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: List.generate(
                                                          dashboardController
                                                              .dashboardModel
                                                              .data!
                                                              .currentFeed!
                                                              .length,
                                                          (index) => Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15),
                                                                child: currentFeedSelection(
                                                                    imagePath: dashboardController
                                                                        .dashboardModel
                                                                        .data!
                                                                        .currentFeed![
                                                                            index]
                                                                        .livestockUri!,
                                                                    index:
                                                                        index),
                                                              )),
                                                    ),

                                                    sizedBoxHeight(10.h),

                                                    // textBlack18W600Mon(
                                                    //     currentFeedData[selectedCurrentFeed]
                                                    //         ["feedFor"]),
                                                    // /
                                                    sizedBoxHeight(15.h),

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        dashboardController
                                                                    .dashboardModel
                                                                    .data!
                                                                    .currentFeed![
                                                                        selectedCurrentFeed]
                                                                    .container ==
                                                                "empty container image"
                                                            ? SvgPicture.asset(
                                                                "assets/images/current_feed.svg",
                                                                height: 170.h,
                                                                width: 100.w,
                                                              )
                                                            : Image.network(
                                                                "${ApiUrls.baseImageUrl}${dashboardController.dashboardModel.data!.currentFeed![selectedCurrentFeed].container}",
                                                                height: 170.h,
                                                                width: 100.w,
                                                              ),

                                                        // sizedBoxWidth(20.w),
                                                        // Spacer(),

                                                        SizedBox(
                                                          // height: 200.h,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: 93.h,
                                                                width: 230.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.h),
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.04),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          2,
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              13.w),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      textGrey4D4D4D_22(
                                                                          // "Dairy"
                                                                          dashboardController
                                                                              .dashboardModel
                                                                              .data!
                                                                              .currentFeed![selectedCurrentFeed]
                                                                              .livestockName!
                                                                          // currentFeedData[
                                                                          //         selectedCurrentFeed]
                                                                          //     ["feedFor"]
                                                                          ),
                                                                      textBlack25W7000(
                                                                          "${dashboardController.dashboardModel.data!.currentFeed![selectedCurrentFeed].currentFeedAvailable!} Kg")
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              sizedBoxHeight(
                                                                  10.h),
                                                              Container(
                                                                height: 93.h,
                                                                width: 230.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.h),
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.04),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          2,
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              13.w),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      textGrey4D4D4D_16(
                                                                          "Reordering Date"),
                                                                      // textGrey4D4D4D_22("Dairy"),
                                                                      // textBlack25W7000("100 Kg")
                                                                      // Row()
                                                                      Row(
                                                                        children: [
                                                                          CircleAvatar(
                                                                            radius:
                                                                                20.h,
                                                                            backgroundColor:
                                                                                AppColors.greyF1F1F1,
                                                                            child:
                                                                                Icon(
                                                                              Icons.calendar_today,
                                                                              size: 20.h,
                                                                              color: AppColors.buttoncolour,
                                                                            ),
                                                                          ),
                                                                          sizedBoxWidth(
                                                                              10.w),
                                                                          textBlack20W7000(Utils.convertISOToFormattedDate(dashboardController
                                                                              .dashboardModel
                                                                              .data!
                                                                              .currentFeed![selectedCurrentFeed]
                                                                              .reorderingDate!))
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    sizedBoxHeight(10.h),

                                                    dashboardController
                                                            .dashboardModel
                                                            .data!
                                                            .currentFeed![
                                                                selectedCurrentFeed]
                                                            .feedLow!
                                                        ? Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .warning_amber_rounded,
                                                                size: 30.h,
                                                                color: AppColors
                                                                    .redFA5658,
                                                              ),
                                                              textBlack18W7000(
                                                                  " Your Feed is Low!"),
                                                              const Spacer(),
                                                              SizedBox(
                                                                height: 45.h,
                                                                width: 120.w,
                                                                child:
                                                                    customButtonCurve(
                                                                        text:
                                                                            "Refill Now",
                                                                        onTap:
                                                                            () {
                                                                          SetupFarmInfoApi()
                                                                              .getFeedLivestockApi()
                                                                              .then((value) {
                                                                            if (value.message ==
                                                                                "Access Denied") {
                                                                              accessDeniedDialog(context, value.message);
                                                                            } else {
                                                                              Get.to(Farmfeedtracker(
                                                                                isInside: true,
                                                                                index: dashboardController.dashboardModel.data!.currentFeed![selectedCurrentFeed].livestockTypeXid!,
                                                                              ));
                                                                            }
                                                                          });
                                                                        }),
                                                              )
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  sizedBoxHeight(dashboardController
                                              .dashboardModel
                                              .data!
                                              .profileCompletionPercentage! >=
                                          100
                                      ? 0.h
                                      : 20.h),
                                  dashboardController.dashboardModel.data!
                                              .profileCompletionPercentage! >=
                                          100
                                      ? const SizedBox()
                                      : textBlack18W7000("Profile"),
                                  dashboardController.dashboardModel.data!
                                              .profileCompletionPercentage! >=
                                          100
                                      ? const SizedBox()
                                      : Container(
                                          // height: 93.h,
                                          // width: 230.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: AppColors.white,
                                            border: Border.all(
                                                color: AppColors.buttoncolour,
                                                width: 1.h),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.04),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 10.h),
                                            child: Row(
                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    SizedBox(
                                                      height: 55.w,
                                                      width: 55.w,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color: AppColors
                                                            .buttoncolour,
                                                        value: dashboardController
                                                                .dashboardModel
                                                                .data!
                                                                .profileCompletionPercentage! /
                                                            100,
                                                        strokeWidth: 5.w,
                                                        backgroundColor:
                                                            AppColors
                                                                .buttoncolour,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation(
                                                                Colors.red),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: -5.h,
                                                      left: 20.h,
                                                      child: Container(
                                                        // height: 93.h,
                                                        // width: 230.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2.h),
                                                          color:
                                                              AppColors.white,
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .buttoncolour,
                                                              width: 1.h),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.04),
                                                              blurRadius: 2,
                                                              spreadRadius: 1,
                                                            )
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      2.w),
                                                          child: textBlack10(
                                                              "${dashboardController.dashboardModel.data!.profileCompletionPercentage} %"),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                        top: 15.h,
                                                        left: 22.5.h,
                                                        child: textBlack18W7000(
                                                            "K"))
                                                  ],
                                                ),
                                                sizedBoxWidth(20.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    textBlack18W7000(
                                                        "Hey ${dashboardController.dashboardModel.data!.userName!}"),

                                                    InkWell(
                                                      onTap: () {
                                                        Get.toNamed("/profile");
                                                        // Get
                                                      },
                                                      child: Container(
                                                        height: 40.h,
                                                        width: 175.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.h),
                                                            color: AppColors
                                                                .buttoncolour),
                                                        child: Center(
                                                          child: Text(
                                                            "Complete Your Profile",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .white,
                                                                fontSize:
                                                                    14.sp),
                                                          ),
                                                        ),
                                                      ),
                                                    )

                                                    // SizedBox(
                                                    //   height: 40.h,
                                                    //   // width: 175.w,
                                                    //   child: customButton(text: "Complete Your Profile"))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                  dashboardController.dashboardModel.data!
                                                  .trainingVideos!.id ==
                                              0 &&
                                          dashboardController
                                                  .dashboardModel
                                                  .data!
                                                  .trainingVideos!
                                                  .title ==
                                              ""
                                      ? const SizedBox()
                                      : sizedBoxHeight(25.h),
                                  dashboardController.dashboardModel.data!
                                                  .trainingVideos!.id ==
                                              0 &&
                                          dashboardController
                                                  .dashboardModel
                                                  .data!
                                                  .trainingVideos!
                                                  .title ==
                                              ""
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () {
                                            Get.toNamed("/videosdetails",
                                                arguments: {
                                                  "videourl":
                                                      dashboardController
                                                          .dashboardModel
                                                          .data!
                                                          .trainingVideos!
                                                          .videoUrl!,
                                                  "title": dashboardController
                                                      .dashboardModel
                                                      .data!
                                                      .trainingVideos!
                                                      .title!,
                                                  "publisheddate":
                                                      dashboardController
                                                          .dashboardModel
                                                          .data!
                                                          .trainingVideos!
                                                          .publishedDatetime,
                                                  "videoId": dashboardController
                                                      .dashboardModel
                                                      .data!
                                                      .trainingVideos!
                                                      .id!,
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(27.h),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.04),
                                                  blurRadius: 10,
                                                  spreadRadius: 2,
                                                )
                                              ],
                                              color: AppColors.pistaE3FFE9,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13.w,
                                                  vertical: 15.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  textBlack18W600Mon(
                                                      "Training"),
                                                  sizedBoxHeight(15.h),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Image.asset(
                                                            "assets/images/thumbnail_icon.png",
                                                            width: 104.w,
                                                            height: 75.h,
                                                            //   fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      sizedBoxWidth(14.w),
                                                      // SvgPicture.asset("assets/images/current_feed.svg",
                                                      //   height: 170.h,
                                                      //   width: 100.w,
                                                      // ),

                                                      // sizedBoxWidth(20.w),
                                                      // Spacer(),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            textBlack18W600Mon(
                                                                dashboardController
                                                                    .dashboardModel
                                                                    .data!
                                                                    .trainingVideos!
                                                                    .title!),
                                                            textGrey4D4D4D_16(
                                                                dashboardController
                                                                    .dashboardModel
                                                                    .data!
                                                                    .trainingVideos!
                                                                    .smallDescription!),
                                                            textGreen14(Utils.formattedTimeAgo(
                                                                dashboardController
                                                                    .dashboardModel
                                                                    .data!
                                                                    .trainingVideos!
                                                                    .publishedDatetime!))
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                  dashboardController
                                              .dashboardModel.data!.article ==
                                          null
                                      ? const SizedBox()
                                      : sizedBoxHeight(20.h),
                                  dashboardController
                                              .dashboardModel.data!.article ==
                                          null
                                      ? const SizedBox()
                                      : Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.grey4D4D4D,
                                                width: 0.5.h),
                                            borderRadius:
                                                BorderRadius.circular(27.h),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.04),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              )
                                            ],
                                            color: AppColors.white,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 13.w,
                                                vertical: 15.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                textBlack18W600Mon(
                                                    "News & Articles"),
                                                sizedBoxHeight(15.h),
                                                InkWell(
                                                  onTap: () async {
                                                    await launchUrl(Uri.parse(
                                                        dashboardController
                                                            .dashboardModel
                                                            .data!
                                                            .article!
                                                            .smallDescription!));
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      dashboardController
                                                              .dashboardModel
                                                              .data!
                                                              .article!
                                                              .smallImageUrl!
                                                              .isEmpty
                                                          ? Image.asset(
                                                              "assets/images/news&arti.png",
                                                              width: 104.w,
                                                              height: 90.h,
                                                            )
                                                          : Image.network(
                                                              "${ApiUrls.baseImageUrl}${dashboardController.dashboardModel.data!.article!.smallImageUrl!}",
                                                              width: 104.w,
                                                              height: 90.h,
                                                            ),
                                                      sizedBoxWidth(14.w),
                                                      // SvgPicture.asset("assets/images/current_feed.svg",
                                                      //   height: 170.h,
                                                      //   width: 100.w,
                                                      // ),

                                                      // sizedBoxWidth(20.w),
                                                      // Spacer(),

                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              dashboardController
                                                                  .dashboardModel
                                                                  .data!
                                                                  .article!
                                                                  .artCategory!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: const Color(
                                                                      0xFF4D4D4D)),
                                                            ),
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Text(
                                                              dashboardController
                                                                  .dashboardModel
                                                                  .data!
                                                                  .article!
                                                                  .title!,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                      0xFF141414)),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  // "7 Feb 2023",
                                                                  Utils.formattedDate(dashboardController
                                                                      .dashboardModel
                                                                      .data!
                                                                      .article!
                                                                      .publishedDatetime!),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xFF4D4D4D)),
                                                                ),
                                                                const Spacer(),
                                                                SizedBox(
                                                                  width: 20.w,
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      saved =
                                                                          !saved;
                                                                    });
                                                                  },
                                                                  child: !saved
                                                                      ? Container(
                                                                          height: 25
                                                                              .h,
                                                                          width: 25
                                                                              .h,
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            "assets/images/saveblank.svg",
                                                                          ))
                                                                      : Container(
                                                                          height:
                                                                              25.h,
                                                                          width:
                                                                              25.h,
                                                                          child:
                                                                              SvgPicture.asset("assets/images/save.svg"),
                                                                        ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          Get.toNamed(
                                                              "/newsandarticlemain");
                                                        },
                                                        child:
                                                            textBlue15NormalMon(
                                                                "View More")),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => feedPerValue.value == 101
                                ? const SizedBox()
                                : Visibility(
                                    visible: lowFeed,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w, vertical: 5.h),
                                        child: Container(
                                          // clipBehavior: Clip.none,
                                          height: 82.h,
                                          // width: double.negativeInfinity,
                                          // width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: AppColors.redFCDADA,
                                            border: Border.all(
                                                color: AppColors.redFA5658,
                                                width: 1.h),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.04),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 10.h),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 25.h,
                                                  backgroundColor:
                                                      AppColors.redFA5658,
                                                  child: CircleAvatar(
                                                    radius: 18.h,
                                                    backgroundColor:
                                                        AppColors.white,
                                                    child: Icon(
                                                      Icons
                                                          .warning_amber_rounded,
                                                      size: 25.h,
                                                      color:
                                                          AppColors.redFA5658,
                                                    ),
                                                  ),
                                                ),
                                                sizedBoxWidth(20.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    textBlack18W7000(
                                                        "Feed Low! Refill Now"),
                                                    textGrey4D4D4D_14(
                                                        "Feed Quantity At ${feedPerValue.value}%")
                                                  ],
                                                ),
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      lowFeed = false;
                                                    });
                                                    // lowFeed = false;
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 17.h,
                                                    backgroundColor:
                                                        AppColors.white,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 25.h,
                                                      color:
                                                          AppColors.grey4D4D4D,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    ));
  }

  Widget rowWithText(String icon, text1, text2) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 25.h,
          width: 25.h,
          color: Colors.black,
        ),
        sizedBoxWidth(5.w),
        textBlack18W5000(
            dashboardController.isLocationFetching.value ? text1 : text2),
      ],
    );
  }

  Future<String> getAddressFromLatLng(double lat, lng) async {
    late final List<Placemark> placemarks;
    await Future.delayed(Duration(seconds: 1), () async {
      placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );
    });

    final locality = placemarks.isNotEmpty ? placemarks[0].locality : '';
    final postalCode = placemarks.isNotEmpty ? placemarks[0].postalCode : '';
    return "${locality!}, ${postalCode!}";
  }

  getCurrentWeatherData(
    double lat,
    double lng,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final placemarks = await placemarkFromCoordinates(
        lat,
        lng,
      );

      final locality = placemarks.isNotEmpty ? placemarks[0].locality : '';
      dashboardController.locationText.value = locality!;
      // log("${locationData.latitude!},${locationData.longitude!}");
      final weatherData = await WeatherApi().getWeatherData(
        lat,
        lng,
      );

      dashboardController.tempValue.value =
          weatherData.data["current"]["temp_c"].toString();
      dashboardController.humidityValue.value =
          weatherData.data["current"]["humidity"].toString();
      dashboardController.windValue.value =
          weatherData.data["current"]["wind_kph"].toString();
      dashboardController.weatherCondition.value =
          weatherData.data["current"]["condition"]['text'].toString();

      await prefs.setString('location', locality);
      await prefs.setString(
          'temperature', weatherData.data["current"]["temp_c"].toString());
      await prefs.setString(
          'wind', weatherData.data["current"]["wind_kph"].toString());
      await prefs.setString(
          'humidity', weatherData.data["current"]["humidity"].toString());
      await prefs.setString('weatherCondition',
          weatherData.data["current"]["condition"]['text'].toString());
    } catch (e) {
      utils.showToast("Error fetching location or weather data");
      //   print("Error fetching location or weather data: $e");
    }
  }

  Future getCurrentAddress() async {
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled && !await location.requestService()) {
      return;
    }

    final permissionGranted = await location.hasPermission();
    if (permissionGranted != ls.PermissionStatus.granted) {
      if (await location.requestPermission() != ls.PermissionStatus.granted) {
        return;
      }
    }

    dashboardController.isLocationFetching.value = true;
    final locationData = await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: false,
    );

    dashboardController.currentLat = locationData.latitude;
    dashboardController.currentLng = locationData.longitude;
    await getCurrentWeatherData(locationData.latitude, locationData.longitude);

    dashboardController.isLocationFetching.value = false;
  }

  Widget currentFeedSelection({required String imagePath, required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCurrentFeed = index;
        });
      },
      child: Container(
        width: 40.w,
        height: 30.h,
        decoration: BoxDecoration(
            // dec
            color: selectedCurrentFeed == index
                ? const Color.fromARGB(255, 236, 248, 239)
                : AppColors.white,
            borderRadius: BorderRadius.circular(5.h),
            border: Border.all(
                color: selectedCurrentFeed == index
                    ? AppColors.buttoncolour
                    : AppColors.grey4D4D4D)),
        child: Padding(
          padding: EdgeInsets.all(4.h),
          child: Image.network("${ApiUrls.baseImageUrl}/$imagePath"),
        ),
      ),
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: 'Example share',
      // text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      // chooserTitle: 'Example Chooser Title'
    );
  }
}
