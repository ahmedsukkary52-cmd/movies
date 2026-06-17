import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moives/config/app_route/app_routes_name.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/config/theme/text_app.dart';
import 'package:moives/features/movies/domain/entities/response/movie_list/movie.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movie, required this.isSmall});

  final Movie movie;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    final rating = movie.rating?.toString() ?? '0.0';
    return RepaintBoundary(
      child: InkWell(
        borderRadius: BorderRadius.circular(10.sp),
        onTap: () {
          context.pushNamed(
            AppRoutes.details,
            pathParameters: {'id': '${movie.id}'},
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          alignment: Alignment.topLeft,
          width: isSmall ? 146.w : 234.w,
          height: isSmall ? 220.w : 352.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            image: movie.mediumCoverImage != null
                ? DecorationImage(
                    image: CachedNetworkImageProvider(
                      movie.mediumCoverImage!,
                      maxWidth: isSmall ? 300 : 480,
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
            color: ColorApp.grayColor,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: ColorApp.transparentGray,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(rating, style: TextApp.regular16White),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(PathImage.star, width: 15.w, height: 15.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
