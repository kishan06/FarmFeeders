import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Widget commonFlushBar(BuildContext context, {required String msg}){
  return Flushbar(
    title:  "Error",
    message:  msg,
    duration:  Duration(seconds: 3),
  )..show(context);
}