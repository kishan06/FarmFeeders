import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../Utils/colors.dart';
import '../Utils/custom_button.dart';
import '../Utils/sized_box.dart';
import '../Utils/texts.dart';
import '../common/custom_button_curve.dart';
import 'payment_successfull.dart';
import 'package:http/http.dart' as http;


class BasicSubscriptionPlan extends StatefulWidget {
  BasicSubscriptionPlan({super.key});

  @override
  State<BasicSubscriptionPlan> createState() => _BasicSubscriptionPlanState();
}

class _BasicSubscriptionPlanState extends State<BasicSubscriptionPlan> {
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              sizedBoxHeight(30.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xffE3FFE9),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xffE3FFE9))),
                child: SvgPicture.asset('assets/images/basePlan.svg'),
              ),
              sizedBoxHeight(10.h),
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 20.h, left: 20.w, right: 20.w, bottom: 35.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xffC9E0FB))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textBlack141414_22w600('Basic Farmer Plan'),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                textBlack20Bold('€'),
                                sizedBoxHeight(40.h)
                              ],
                            ),
                            // textBlack60w600('99.9 '),
                            textBlack50w600('99.9 '),

                            textBlack20Bold('/mo')
                          ],
                        ),
                        sizedBoxHeight(10.h),
                        rowWidget('Attractive Discounts on all Feed Orders'),
                        rowWidget('Feed Storage Tracking and Alerts'),
                        rowWidget('Feed Delivery Tracking'),
                        rowWidget('Connect with experts for assistance'),
                        rowWidget('Farm Hand Training: Videos and Notes'),
                        sizedBoxHeight(20.h),
                        customButtonCurve(
                          text: 'Get a 3 Months Trail',
                          onTap: () {
                            makePayment();

                            // /
                            // Get.offAll(() => const PaymentSuccessfull());

                            // Future.delayed(Duration(seconds: 3), () {
                            //   showDialog(
                            //       context: context,
                            //       builder: (context) => addCommunityDailog());
                            // });
                          },
                        )
                      ],
                    ),
                  ),
                  SvgPicture.asset('assets/images/Line.svg'),
                  SvgPicture.asset('assets/images/Line2.svg'),
                ],
              ),
              sizedBoxHeight(20.h)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('99.9', 'EUR');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  
                  billingDetails: BillingDetails(
                      
                      address: Address(
                          city: null,
                          country: "IE",
                          line1: null,
                          line2: null,
                          postalCode: null,
                          state: null)),
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'description' : {
          "userId": "1",
          "planId": "12"
        }.toString()
        // 'metadata': {
        //   'order_id': "1",
        //   'customer_id': "12"
        // }
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51NleA3BYVJTtq48mcNufuLvW5uC5hyOZHm0IDzuRf2F9Ahtn1nW4AXqJYpPQKqoFNeT8zW3CUF11x1Kmf2MDEAZI00lfdGhUMP',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print("resp" + response.body);
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        Get.offAll(() => const PaymentSuccessfull());

        // showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //           content: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Icon(
        //                 Icons.check_circle,
        //                 color: Colors.green,
        //                 size: 100.0,
        //               ),
        //               SizedBox(height: 10.0),
        //               Text("Payment Successful!"),
        //             ],
        //           ),
        //         ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = ((double.parse(amount)) * 100).toInt();
    return calculatedAmout.toString();
  }

  Widget rowWidget(String txt) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                sizedBoxHeight(5.h),
                SvgPicture.asset('assets/images/check2.svg'),
              ],
            ),
            sizedBoxWidth(15.w),
            Flexible(child: textBlack18W7000(txt))
          ],
        ),
        sizedBoxHeight(10.h)
      ],
    );
  }
}
