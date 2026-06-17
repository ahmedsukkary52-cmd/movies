import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenShotsItem extends StatelessWidget {
  final String screenShotImage;

  const ScreenShotsItem({super.key, required this.screenShotImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 167.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: CachedNetworkImage(imageUrl: screenShotImage, fit: BoxFit.cover,),
    );
  }
}
