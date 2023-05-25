import 'package:farmfeeders/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormFieldBorder extends StatefulWidget {
  CustomTextFormFieldBorder({
    Key? key,
    this.validator,
    this.inputFormatters,
    required this.hintText,
    required this.validatorText,
    this.textEditingController,
    this.leadingIcon,
    this.readonly = false,
    this.textCapital = false,
    this.isInputPassword = false,
    this.outlineColor = const Color(0xFFFFB600),
    // this.keyboardType,
    this.texttype,
  }) : super(key: key);

  final dynamic validator;
  final TextEditingController? textEditingController;
  final String hintText;
  final String validatorText;
  final Widget? leadingIcon;
  final bool isInputPassword;
  final bool readonly;
  final bool textCapital;
  final dynamic inputFormatters;
  final Color outlineColor;
  // final TextInputType? keyboardType;
  final TextInputType? texttype;

  @override
  State<CustomTextFormFieldBorder> createState() => _CustomtextFormFieldBorderState();
}

class _CustomtextFormFieldBorderState extends State<CustomTextFormFieldBorder> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isInputPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textCapitalization: widget.textCapital
            ? TextCapitalization.characters
            : TextCapitalization.none,
        style: TextStyle(
          fontSize: 16.sp,
        ),
        readOnly: widget.readonly,
        cursorColor: const Color(0xFF1B8DC9),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 12.sp),
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.buttoncolour, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.buttoncolour, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.buttoncolour, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          hintStyle: TextStyle(
              color: Color(0x80000000), fontSize: 16.sp, fontFamily: "Poppins"),
          hintText: widget.hintText,
          prefixIcon: widget.leadingIcon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: widget.leadingIcon!,
                ),
          suffixIcon: widget.isInputPassword
              ? GestureDetector(
                  onTap: () => setState(() => obscureText = !obscureText),
                  child: obscureText
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: SvgPicture.asset(
                                "assets/images/eye-closed-svgrepo-com.svg",
                                color: Color(0XFF959595),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Color(0xFF959595),
                              ),
                            ),
                          ],
                        ),
                )
              : null,
        ),
        keyboardType: widget.texttype,
        validator: widget.validator,
        inputFormatters: widget.inputFormatters);
  }
}
