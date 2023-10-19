import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

Widget commonFlushBar(BuildContext context, {String? title, required String msg}){
  return Flushbar(
    title: title == null ? "Error" : title,
    message:  msg,
    duration:  Duration(seconds: 3),
  )..show(context);
}