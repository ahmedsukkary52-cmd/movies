import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moives/config/theme/path_image.dart';

import '../../../config/theme/color_app.dart';
import '../../../config/theme/text_app.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatefulWidget {
  final Widget? prefixIconName;
  final bool hasSuffix;
  final bool obscureText;
  final String hintText;
  final TextEditingController? controller;
  final OnValidator validator;
  final String? prefixTxt;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

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
    this.prefixTxt = '',
    this.onChange,
    this.keyboardType
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
    final transparentBorder =
    buildOutlineInputBorder(ColorApp.transparent);

    final errorBorder =
    buildOutlineInputBorder(ColorApp.primary);

    return TextFormField(
      onFieldSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChange,
      keyboardType: widget.keyboardType,
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
        enabledBorder: transparentBorder,
        errorBorder: errorBorder,
        focusedBorder: transparentBorder,
        focusedErrorBorder: errorBorder,
        hintText: widget.hintText,
        hintStyle: TextApp.regular16White,
        prefixIcon: Container(
          padding: EdgeInsets.only(
            left: 14.w,
            right: 12.w,
            bottom: 8.h,
            top: 8.h,
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
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: SvgPicture.asset(
                isObscured
                    ? PathImage.unVisible
                    : PathImage.visible,
              ),
            )
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
