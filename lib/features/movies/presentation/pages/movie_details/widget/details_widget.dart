import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:moives/config/theme/text_app.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({super.key, required this.icon, required this.number});

  final String icon;
  final num number;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: 122.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: ColorApp.grayColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(icon),
          Text('$number', style: TextApp.bold24White),
        ],
      ),
    );
  }
}
