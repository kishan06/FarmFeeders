import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    Key? key,
    this.validator,
    this.inputFormatters,
    required this.hintText,
    required this.validatorText,
    this.textEditingController,
    this.leadingIcon,
    this.onTap,
    this.eyeIcon = false,
    this.onChanged,
    this.suffixIcon,
    this.readonly = false,
    this.isInputPassword = false,
    this.outlineColor = const Color(0xFFFFB600),
    // this.keyboardType,
    this.suffixIconConstraints,
    this.texttype,
  }) : super(key: key);

  final dynamic validator;
  final TextEditingController? textEditingController;
  final String hintText;
  final String validatorText;
  final Widget? leadingIcon;
  final bool eyeIcon;
  final Widget? suffixIcon;
  final bool isInputPassword;
  void Function(String)? onChanged;
  void Function()? onTap;
  final bool readonly;
  final dynamic inputFormatters;
  final Color outlineColor;
  final BoxConstraints? suffixIconConstraints;

  final TextInputType? texttype;

  @override
  State<CustomTextFormField> createState() => _CustomtextFormFieldState();
}

class _CustomtextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;
  // late bool eyeseIcon;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isInputPassword;
    // eyeseIcon = widget.eyeIcon;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 16.sp,

        ),
        onChanged: widget.onChanged,
        readOnly: widget.readonly,
        cursorColor: const Color(0xFF3B3F43),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        controller: widget.textEditingController,
        onTap: widget.onTap,
        decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 14.sp,
              // overflow: TextOverflow.visible
            ),
            isCollapsed: true,
            suffixIconConstraints: const BoxConstraints(),
            contentPadding: EdgeInsets.all(17.h),
            filled: true,
            fillColor: Color(0xFFF1F1F1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide(color: Color(0xFF707070).withOpacity(0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide(color: Color(0xFF707070).withOpacity(0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide(color: Color(0xFF707070).withOpacity(0), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            hintStyle: TextStyle(
                color: const Color(0xFF54595F63),
                fontSize: 15.sp,
                fontFamily: "Roboto"),
            hintText: widget.hintText,
            prefixIcon: widget.leadingIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: widget.leadingIcon!,
                  ),
            // suffixIcon: widget.leadingIcon == null
            //     ? null
            //     : Padding(
            //         padding: const EdgeInsets.only(left: 14, right: 14),
            //         child: widget.leadingIcon!,
            //       ),
            prefixIconConstraints: const BoxConstraints(minWidth: 20),
            suffixIcon: widget.isInputPassword
                ? Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: eyesuffix(),
                  )
                : SizedBox()),
        keyboardType: widget.texttype,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters);
  }

  Widget eyesuffix() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => setState(() => obscureText = !obscureText),
        child: obscureText
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Icon(
                      Icons.visibility_off,
                      color: Colors.black54,
                      size: 20.sp,
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                    ),
                    child: Icon(
                      Icons.visibility,
                      color: Colors.black54,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
