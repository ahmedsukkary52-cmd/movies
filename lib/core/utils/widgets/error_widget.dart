import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/path_image.dart';
import '../../../config/theme/text_app.dart';
import 'custom_elevated_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(PathImage.mainError),
            SizedBox(height: 24.h),
            Text(
              message,
              style: TextApp.bold20White,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'Something went wrong, please try again',
              style: TextApp.regular20White,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            CustomElevatedButton(
              text: 'Try Again',
              textStyle: TextApp.regular20BlackRoboto,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
