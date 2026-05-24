import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/theme/color_app.dart';
import '../../../../../../config/theme/path_image.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorApp.grayColor,
        borderRadius: BorderRadius.circular(22.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(icon: PathImage.home, index: 0, context: context),
          navItem(icon: PathImage.search, index: 1, context: context),
          navItem(icon: PathImage.explore, index: 2, context: context),
          navItem(icon: PathImage.profile, index: 3, context: context),
        ],
      ),
    );
  }

  Widget navItem({
    required String icon,
    required int index,
    required BuildContext context,
  }) {
    final isSelected = index == currentIndex;

    return IconButton(
      onPressed: () => onTap(index),
      icon: SvgPicture.asset(
        icon,
        color: isSelected ? ColorApp.primary : ColorApp.whiteColor,
      ),
    );
  }
}
