import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moives/config/theme/path_image.dart';

import '../../../../../../config/theme/color_app.dart';
import '../../../../../../config/theme/text_app.dart';

class CastItem extends StatelessWidget {
  final String castImage;

  final String castName;

  final String castCharacter;

  const CastItem({
    super.key,
    required this.castImage,
    required this.castCharacter,
    required this.castName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorApp.grayColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 70.h,
              margin: EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: castImage == ""
                  ? Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: SvgPicture.asset(PathImage.error),
                    )
                  : Image.network(castImage, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(child: Text(
                    'Name : $castName', style: TextApp.regular20White,
                    overflow: TextOverflow.ellipsis)),
                SizedBox(
                  child: Text(
                    'Character : $castCharacter',
                    style: TextApp.regular20White,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
