import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/models/weather_model.dart';
import 'package:farmfeeders/view_models/WeatherApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/sized_box.dart';
import '../../Utils/texts.dart';
import '../../controller/dashboard_controller.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  DashboardController dashboardController = Get.put(DashboardController());

  Stream<DateTime>? _clockStream;
  String? place = "Unknown",
      temperature = "00.0",
      humidity = "0",
      wind = "00.0",
      weatherCondition = "";

  bool isDaytimeNow(
      DateTime currentTime, DateTime sunriseTime, DateTime sunsetTime) {
    return currentTime.isAfter(sunriseTime) && currentTime.isBefore(sunsetTime);
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
  void dispose() {
    // Cancel the stream subscription to avoid memory leaks
    // _clockStream?.cancel();
    super.dispose();
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

  String getWeekdayName(DateTime date) {
    // Format the date to get the weekday name
    return DateFormat('EEEE').format(date);
  }

  @override
  void initState() {
    dashboardController.isWeatherForecastLoading.value = true;

    _clockStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final weatherData = await WeatherApi().getWeatherForecastData(
          dashboardController.currentLat!, dashboardController.currentLng);
      dashboardController.weatherModel.clear();
      for (var a in weatherData.data["forecast"]["forecastday"]) {
        DateTime date = DateTime.parse(a["date"]);
        String weekdayName = getWeekdayName(date);
        dashboardController.weatherModel.add(WeatherModel(
            name: weekdayName,
            tempC: a["day"]["maxtemp_c"].toString(),
            tempF: a["day"]["maxtemp_f"].toString(),
            condition: a["day"]['condition']['text']));
      }

      dashboardController.isWeatherForecastLoading.value = false;
    });

    super.initState();
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

    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                    color: AppColors.pistaE3FFE9,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(38),
                        bottomRight: Radius.circular(38))),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: (dashboardController.weatherCondition.value == "Sunny" ||
                                dashboardController.weatherCondition.value ==
                                    "Clear")
                            ? isDaytime
                                ? Lottie.asset(
                                    "assets/lotties/sun_animation.json",
                                    height: 200.h,
                                    width: 200.w,
                                  )
                                : Lottie.asset(
                                    "assets/lotties/moon_animation.json",
                                    height: 175.h,
                                    width: 175.w,
                                  )
                            : (dashboardController.weatherCondition.value ==
                                    "Partly cloudy")
                                ? isDaytime
                                    ? Lottie.asset(
                                        "assets/lotties/sun_with_cloud_animation.json",
                                        height: 200.h,
                                        width: 200.w,
                                      )
                                    : Lottie.asset(
                                        "assets/lotties/moon_with_cloud_animation.json",
                                        height: 200.h,
                                        width: 200.w,
                                      )
                                : (dashboardController.weatherCondition.value == "Cloudy" ||
                                        dashboardController.weatherCondition.value ==
                                            "Overcast")
                                    ? Lottie.asset(
                                        "assets/lotties/clouds.json",
                                        height: 200.h,
                                        width: 200.w,
                                      )
                                    : (dashboardController.weatherCondition.value == "Mist" ||
                                            dashboardController.weatherCondition.value ==
                                                "Fog" ||
                                            dashboardController.weatherCondition.value ==
                                                "Freezing fog")
                                        ? Lottie.asset(
                                            "assets/lotties/cloud2.json",
                                            height: 200.h,
                                            width: 200.w,
                                          )
                                        : (dashboardController.weatherCondition.value == "Patchy rain possible" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Patchy freezing drizzle possible" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Thundery outbreaks possible" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Patchy light drizzle" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Light drizzle" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Freezing drizzle" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Heavy freezing drizzle " ||
                                                dashboardController.weatherCondition.value ==
                                                    "Patchy light rain" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Light rain" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Moderate rain at times" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Moderate rain" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Heavy rain at times" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Heavy rain" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Light freezing rain" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Moderate or heavy freezing rain" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Torrential rain shower" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Light sleet showers" ||
                                                dashboardController.weatherCondition.value ==
                                                    "Patchy light rain with thunder" ||
                                                dashboardController.weatherCondition.value == "Moderate or heavy rain with thunder")
                                            ? Lottie.asset(
                                                "assets/lotties/cloud_with_rain_animation.json",
                                                height: 200.h,
                                                width: 200.w,
                                              )
                                            : (dashboardController.weatherCondition.value == "Patchy snow possible" || dashboardController.weatherCondition.value == "Patchy sleet possible" || dashboardController.weatherCondition.value == "Light sleet" || dashboardController.weatherCondition.value == "Moderate or heavy sleet" || dashboardController.weatherCondition.value == "Patchy light snow" || dashboardController.weatherCondition.value == "Light snow" || dashboardController.weatherCondition.value == "Patchy moderate snow" || dashboardController.weatherCondition.value == "Moderate snow" || dashboardController.weatherCondition.value == "Patchy heavy snow" || dashboardController.weatherCondition.value == "Heavy snow" || dashboardController.weatherCondition.value == "Ice pellets" || dashboardController.weatherCondition.value == "Moderate or heavy sleet showers" || dashboardController.weatherCondition.value == "Light snow showers" || dashboardController.weatherCondition.value == "Moderate or heavy snow showers" || dashboardController.weatherCondition.value == "Light showers of ice pellets" || dashboardController.weatherCondition.value == "Moderate or heavy showers of ice pellets")
                                                ? Lottie.asset(
                                                    "assets/lotties/snow_animation.json",
                                                    height: 200.h,
                                                    width: 200.w,
                                                  )
                                                : (dashboardController.weatherCondition.value == "Blowing snow" || dashboardController.weatherCondition.value == "Blizzard" || dashboardController.weatherCondition.value == "Patchy light snow with thunder" || dashboardController.weatherCondition.value == "Moderate or heavy snow with thunder")
                                                    ? Lottie.asset(
                                                        "assets/lotties/snow_animation.json",
                                                        height: 200.h,
                                                        width: 200.w,
                                                      )
                                                    : Lottie.asset(
                                                        "assets/lotties/cloud2.json",
                                                        height: 200.h,
                                                        width: 200.w,
                                                      )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 15.h, 36.w, 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/locationconnect.svg",
                                            color: AppColors.black,
                                            height: 20.h,
                                            width: 20.h,
                                          ),
                                          sizedBoxWidth(5.w),
                                          textBlack18W5000(dashboardController
                                              .locationText.value)
                                        ],
                                      ),
                                      textGreen50Bold(
                                          "${dashboardController.tempValue.value}° C"),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          rowWithText(
                                              "assets/images/humidity.png",
                                              humidity!,
                                              dashboardController
                                                  .humidityValue.value),
                                          rowWithText(
                                              "assets/images/wind.png",
                                              "${wind!} kph",
                                              "${dashboardController.windValue.value} kph"),
                                        ],
                                      ),
                                      StreamBuilder<DateTime>(
                                        stream: _clockStream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            String formattedDateTime =
                                                DateFormat('E, d MMM - hh:mm a')
                                                    .format(snapshot.data!);

                                            return Center(
                                              child: textBlack18W5000(
                                                formattedDateTime,
                                              ),
                                            );
                                          } else {
                                            return textBlack18W5000(
                                                'Loading...');
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
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  "5 - day forecast",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              dashboardController.isWeatherForecastLoading.value
                  ? Container(
                      margin: const EdgeInsets.only(
                        top: 150,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.buttoncolour,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dashboardController.weatherModel.length,
                      itemBuilder: (ctx, index) {
                        return index == 0
                            ? const SizedBox()
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: index % 2 != 0
                                        ? Colors.white
                                        : const Color(0xFFF4FEF5),
                                    border: Border.all(
                                        width: 1,
                                        color: index % 2 != 0
                                            ? const Color(0xFFE1F4E4)
                                            : const Color(0xFFF4FEF5))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          dashboardController
                                              .weatherModel[index].name!,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: (dashboardController
                                                              .weatherModel[
                                                                  index]
                                                              .condition ==
                                                          "Sunny" ||
                                                      dashboardController
                                                              .weatherModel[
                                                                  index]
                                                              .condition ==
                                                          "Clear")
                                                  ? isDaytime
                                                      ? Lottie.asset(
                                                          "assets/lotties/sun_animation.json",
                                                          height: 30.h,
                                                          width: 30.w,
                                                        )
                                                      : Lottie.asset(
                                                          "assets/lotties/moon_animation.json",
                                                          height: 30.h,
                                                          width: 30.w,
                                                        )
                                                  : (dashboardController.weatherModel[index].condition ==
                                                          "Partly cloudy")
                                                      ? isDaytime
                                                          ? Lottie.asset(
                                                              "assets/lotties/sun_with_cloud_animation.json",
                                                              height: 30.h,
                                                              width: 30.w,
                                                            )
                                                          : Lottie.asset(
                                                              "assets/lotties/moon_with_cloud_animation.json",
                                                              height: 30.h,
                                                              width: 30.w,
                                                            )
                                                      : (dashboardController.weatherModel[index].condition ==
                                                                  "Cloudy" ||
                                                              dashboardController
                                                                      .weatherModel[
                                                                          index]
                                                                      .condition ==
                                                                  "Overcast")
                                                          ? Lottie.asset(
                                                              "assets/lotties/clouds.json",
                                                              height: 30.h,
                                                              width: 30.w,
                                                            )
                                                          : (dashboardController.weatherModel[index].condition ==
                                                                      "Mist" ||
                                                                  dashboardController.weatherModel[index].condition ==
                                                                      "Fog" ||
                                                                  dashboardController.weatherModel[index].condition ==
                                                                      "Freezing fog")
                                                              ? Lottie.asset(
                                                                  "assets/lotties/cloud2.json",
                                                                  height: 30.h,
                                                                  width: 30.w,
                                                                )
                                                              : (dashboardController.weatherModel[index].condition == "Patchy rain possible" ||
                                                                      dashboardController.weatherModel[index].condition ==
                                                                          "Patchy freezing drizzle possible" ||
                                                                      dashboardController.weatherModel[index].condition == "Thundery outbreaks possible" ||
                                                                      dashboardController.weatherModel[index].condition == "Patchy light drizzle" ||
                                                                      dashboardController.weatherModel[index].condition == "Light drizzle" ||
                                                                      dashboardController.weatherModel[index].condition == "Freezing drizzle" ||
                                                                      dashboardController.weatherModel[index].condition == "Heavy freezing drizzle " ||
                                                                      dashboardController.weatherModel[index].condition == "Patchy light rain" ||
                                                                      dashboardController.weatherModel[index].condition == "Light rain" ||
                                                                      dashboardController.weatherModel[index].condition == "Moderate rain at times" ||
                                                                      dashboardController.weatherModel[index].condition == "Moderate rain" ||
                                                                      dashboardController.weatherModel[index].condition == "Heavy rain at times" ||
                                                                      dashboardController.weatherModel[index].condition == "Heavy rain" ||
                                                                      dashboardController.weatherModel[index].condition == "Light freezing rain" ||
                                                                      dashboardController.weatherModel[index].condition == "Moderate or heavy freezing rain" ||
                                                                      dashboardController.weatherModel[index].condition == "Torrential rain shower" ||
                                                                      dashboardController.weatherModel[index].condition == "Light sleet showers" ||
                                                                      dashboardController.weatherModel[index].condition == "Patchy light rain with thunder" ||
                                                                      dashboardController.weatherModel[index].condition == "Moderate or heavy rain with thunder")
                                                                  ? Lottie.asset(
                                                                      "assets/lotties/cloud_with_rain_animation.json",
                                                                      height:
                                                                          30.h,
                                                                      width:
                                                                          30.w,
                                                                    )
                                                                  : (dashboardController.weatherModel[index].condition == "Patchy snow possible" || dashboardController.weatherModel[index].condition == "Patchy sleet possible" || dashboardController.weatherModel[index].condition == "Light sleet" || dashboardController.weatherModel[index].condition == "Moderate or heavy sleet" || dashboardController.weatherModel[index].condition == "Patchy light snow" || dashboardController.weatherModel[index].condition == "Light snow" || dashboardController.weatherModel[index].condition == "Patchy moderate snow" || dashboardController.weatherModel[index].condition == "Moderate snow" || dashboardController.weatherModel[index].condition == "Patchy heavy snow" || dashboardController.weatherModel[index].condition == "Heavy snow" || dashboardController.weatherModel[index].condition == "Ice pellets" || dashboardController.weatherModel[index].condition == "Moderate or heavy sleet showers" || dashboardController.weatherModel[index].condition == "Light snow showers" || dashboardController.weatherModel[index].condition == "Moderate or heavy snow showers" || dashboardController.weatherModel[index].condition == "Light showers of ice pellets" || dashboardController.weatherModel[index].condition == "Moderate or heavy showers of ice pellets")
                                                                      ? Lottie.asset(
                                                                          "assets/lotties/snow_animation.json",
                                                                          height:
                                                                              30.h,
                                                                          width:
                                                                              30.w,
                                                                        )
                                                                      : (dashboardController.weatherModel[index].condition == "Blowing snow" || dashboardController.weatherModel[index].condition == "Blizzard" || dashboardController.weatherModel[index].condition == "Patchy light snow with thunder" || dashboardController.weatherModel[index].condition == "Moderate or heavy snow with thunder")
                                                                          ? Lottie.asset(
                                                                              "assets/lotties/snow_animation.json",
                                                                              height: 30.h,
                                                                              width: 30.w,
                                                                            )
                                                                          : Lottie.asset(
                                                                              "assets/lotties/cloud2.json",
                                                                              height: 30.h,
                                                                              width: 30.w,
                                                                            )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${dashboardController.weatherModel[index].tempC!}°C / "
                                            "${dashboardController.weatherModel[index].tempF!}°F",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
