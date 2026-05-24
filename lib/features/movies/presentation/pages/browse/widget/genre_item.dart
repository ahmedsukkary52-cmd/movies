import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:moives/config/theme/text_app.dart';

class GenreWidget extends StatelessWidget {
  const GenreWidget({
    super.key,
    required this.isSelected,
    required this.genreName,
    required this.onTap,
  });

  final bool isSelected;
  final String genreName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.sp),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? ColorApp.primary : ColorApp.black,
          borderRadius: BorderRadius.circular(16.sp),
          border: BoxBorder.all(color: ColorApp.primary, width: 2),
        ),
        child: Text(
          genreName,
          style: isSelected ? TextApp.bold20Black : TextApp.bold20Wallow,
        ),
      ),
    );
  }
}
