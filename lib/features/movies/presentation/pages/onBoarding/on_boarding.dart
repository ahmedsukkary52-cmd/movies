import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:moives/config/app_route/app_routes_name.dart';
import 'package:moives/features/movies/presentation/pages/onBoarding/widget/build_footer.dart';

import '../../../../../config/theme/color_app.dart';
import '../../../../../config/theme/path_image.dart';
import '../../../../../config/theme/text_app.dart';
import '../../../../../core/utils/widgets/custom_elevated_button.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final List<String> allWords = [
    "Explore Now",
    "Find Your Next Favorite Movie Here",
    'Get access to a huge library of movies to suit all tastes. You will surely like it.',
    'Discover Movies',
    'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
    'Explore All Genres',
    'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
    'Create Watch List',
    'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
    'Rate, Review, and Learn',
    "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
    'Finish',
    "Start Watching Now",
  ];
  int currentIndex = 0;
  final introKey = GlobalKey<IntroductionScreenState>();

  final PageDecoration pageDecoration = const PageDecoration(
    pageMargin: EdgeInsets.zero,
    safeArea: 0,
    footerFlex: 0,
    footerPadding: EdgeInsets.zero,
  );

  Text body(String bodyString) {
    return Text(
      bodyString,
      style: TextApp.regular20White,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: IntroductionScreen(
        key: introKey,

        curve: Curves.easeInOutCubic,
        animationDuration: 600,
        globalBackgroundColor: ColorApp.black,

        onChange: (index) {
          currentIndex = index;
          setState(() {});
        },

        showDoneButton: false,
        showBackButton: false,
        showNextButton: false,
        showSkipButton: false,
        showBottomPart: false,

        pages: [
          PageViewModel(
            decoration: PageDecoration(
              safeArea: 24.h,
              footerFlex: 0,
              bodyFlex: 0,
            ),
            footer: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              child: CustomElevatedButton(
                text: allWords[0],
                onPressed: next,
                textStyle: TextApp.semiBold20black,
              ),
            ),
            backgroundImage: PathImage.onboarding1,
            titleWidget: Text(
              allWords[1],
              style: TextApp.medium36White,
              textAlign: TextAlign.center,
            ),
            bodyWidget: body(allWords[2]),
          ),
          PageViewModel(
            backgroundImage: PathImage.onboarding2,
            title: '',
            body: '',
            decoration: pageDecoration,
            footer: BuildFooter(
              onPressed: next,
              haveBack: false,
              titleString: allWords[3],
              bodyString: allWords[4],
            ),
          ),
          PageViewModel(
            backgroundImage: PathImage.onboarding3,
            title: '',
            body: '',
            decoration: pageDecoration,
            footer: BuildFooter(
              onPressed: next,
              onBack: back,
              haveBack: true,
              titleString: allWords[5],
              bodyString: allWords[6],
            ),
          ),
          PageViewModel(
            backgroundImage: PathImage.onboarding4,
            title: '',
            body: '',
            decoration: pageDecoration,
            footer: BuildFooter(
              onPressed: next,
              onBack: back,
              haveBack: true,
              titleString: allWords[7],
              bodyString: allWords[8],
            ),
          ),
          PageViewModel(
            backgroundImage: PathImage.onboarding5,
            title: '',
            body: '',
            decoration: pageDecoration,
            footer: BuildFooter(
              onPressed: next,
              onBack: back,
              haveBack: true,
              titleString: allWords[9],
              bodyString: allWords[10],
            ),
          ),
          PageViewModel(
            backgroundImage: PathImage.onboarding6,
            title: '',
            body: '',
            decoration: pageDecoration,
            footer: BuildFooter(
              onBack: back,
              onPressed: onFinish,
              haveBack: true,
              elevated: allWords[11],
              titleString: allWords[12],
              bodyString: '',
              isLastPage: true,
            ),
          ),
        ],
      ),
    );
  }

  void next() => introKey.currentState?.next();

  void back() => introKey.currentState?.previous();

  void onFinish() => context.push(AppRoutes.main);
}
