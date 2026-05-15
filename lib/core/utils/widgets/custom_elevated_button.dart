import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/color_app.dart';
import '../../../config/theme/path_image.dart';
import '../../../config/theme/text_app.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? height;
  final TextStyle? textStyle;

  final Color background;
  final bool hasIcon;
  final String text;
  final String? iconImage;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final bool hasBorder;
  final Widget? customWidgetWithIcon;

  const CustomElevatedButton({
    super.key,
    this.iconImage,
    this.customWidgetWithIcon,
    this.height,
    this.iconColor,
    this.hasIcon = false,
    required this.text,
    required this.onPressed,
    this.background = ColorApp.primary,
    this.textStyle,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height ?? 55.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: hasBorder ? ColorApp.transparent : background,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: hasBorder
                ? BorderSide(color: ColorApp.primary, width: 2)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(15.sp),
          ),
        ),
        onPressed: onPressed,
        child: hasIcon == true
            ? customWidgetWithIcon ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage(iconImage ?? PathImage.google),
                        color: iconColor ?? ColorApp.black,
                        size: 22,
                      ),
                      SizedBox(width: 12.w),
                      Text(text, style: TextApp.regular20black),
                    ],
                  )
            : Text(text, style: textStyle ?? TextApp.regular20black),
      ),
    );
  }
}
