import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/color_app.dart';
import '../../../../../../config/theme/text_app.dart';
import '../../../../../../core/utils/widgets/custom_elevated_button.dart';

class BuildFooter extends StatelessWidget {
  const BuildFooter({
    super.key,
    this.onBack,
    this.isLastPage = false,
    required this.onPressed,
    required this.haveBack,
    required this.titleString,
    required this.bodyString,
    this.elevated = 'Next',
  });

  final VoidCallback onPressed;

  final VoidCallback? onBack;

  final bool isLastPage;
  final bool haveBack;
  final String titleString;
  final String bodyString;
  final String elevated;

  Text title(String titleString) {
    return Text(titleString, style: TextApp.bold24White);
  }

  Text body(String bodyString) {
    return Text(
      bodyString,
      style: TextApp.regular20White,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorApp.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        bottom: 20.h,
        start: 16.w,
        end: 16.w,
        top: 34.h,
      ),
      child: Column(
        spacing: 24.h,
        children: [
          Column(
            children: [
              title(titleString),
              isLastPage ? SizedBox() : SizedBox(height: 12.h),
              isLastPage ? SizedBox() : body(bodyString),
            ],
          ),
          Column(
            spacing: 16.h,
            children: [
              CustomElevatedButton(
                text: elevated,
                onPressed: onPressed,
                textStyle: TextApp.semiBold20black,
              ),
              haveBack
                  ? CustomElevatedButton(
                      text: 'back',
                      onPressed: onBack,
                      hasBorder: true,
                      textStyle: TextApp.semiBold20Wallow,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
