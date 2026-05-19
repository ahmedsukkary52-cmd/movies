import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/color_app.dart';
import '../../../../../../config/theme/text_app.dart';

class GenreItem extends StatelessWidget {
  final String genre;

  const GenreItem({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentGeometry.center,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorApp.grayColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(genre, style: TextApp.regular16White),
    );
  }
}
