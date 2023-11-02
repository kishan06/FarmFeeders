import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorMsg extends StatelessWidget {
  String? msg;
  ErrorMsg({super.key,this.msg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        // _data[index]['title'] ?? "",
        msg??"Something went wrong",
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
