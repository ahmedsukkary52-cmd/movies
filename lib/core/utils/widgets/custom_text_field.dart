import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/color_app.dart';
import '../../../config/theme/text_app.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatefulWidget {
  final Widget? prefixIconName;
  final bool hasSuffix;
  final bool obscureText;
  final bool isNumber;

  final String hintText;
  final TextEditingController? controller;
  final OnValidator validator;
  final String? prefixTxt;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    this.textInputAction,
    this.onSubmitted,
    this.prefixIconName,
    required this.hintText,
    this.controller,
    this.validator,
    this.hasSuffix = false,
    this.obscureText = false,
    this.isNumber = false,
    this.prefixTxt = '',
    this.onChange,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChange,
      keyboardType: widget.isNumber ? TextInputType.numberWithOptions() : null,
      style: TextApp.regular16White,
      cursorColor: ColorApp.whiteColor,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isObscured,
      decoration: InputDecoration(
        prefixText: widget.prefixTxt,
        hoverColor: ColorApp.whiteColor,
        filled: true,
        fillColor: ColorApp.grayColor,
        enabledBorder: buildOutlineInputBorder(ColorApp.transparent),
        errorBorder: buildOutlineInputBorder(ColorApp.primary),
        focusedBorder: buildOutlineInputBorder(ColorApp.transparent),
        focusedErrorBorder: buildOutlineInputBorder(ColorApp.primary),
        hintText: widget.hintText,
        hintStyle: TextApp.regular16White,
        prefixIcon: Container(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 12.w,
            bottom: 12.h,
            top: 12.h,
          ),
          child: widget.prefixIconName,
        ),
        suffixIcon: widget.hasSuffix
            ? InkWell(
                onTap: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
                child: isObscured
                    ? Icon(
                        Icons.visibility_off,
                        color: ColorApp.whiteColor,
                        size: 26,
                      )
                    : Icon(
                        Icons.visibility,
                        color: ColorApp.whiteColor,
                        size: 26,
                      ),
              )
            : null,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 1, color: borderColor),
    );
  }
}
