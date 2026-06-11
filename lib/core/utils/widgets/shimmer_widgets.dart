import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorApp.grayColor,
      highlightColor: ColorApp.grayTextColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorApp.grayColor,
          borderRadius: BorderRadius.circular(radius.sp),
        ),
      ),
    );
  }
}

class MovieItemShimmer extends StatelessWidget {
  final bool isSmall;

  const MovieItemShimmer({super.key, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      width: isSmall ? 146.w : 234.w,
      height: isSmall ? 220.h : 352.h,
      radius: 20,
    );
  }
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 130.h),
          SizedBox(
            height: 352.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: MovieItemShimmer(isSmall: false),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(left: 16.w, bottom: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(width: 100.w, height: 20.h),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 220.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: MovieItemShimmer(isSmall: true),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridShimmer extends StatelessWidget {
  const GridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.w,
        mainAxisExtent: 260.h,
        crossAxisSpacing: 20.w,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => MovieItemShimmer(isSmall: true),
    );
  }
}

class ProfileGrid extends StatelessWidget {
  const ProfileGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15.w,
        mainAxisExtent: 210.h,
        crossAxisSpacing: 15.w,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => MovieItemShimmer(isSmall: true),
    );
  }
}
