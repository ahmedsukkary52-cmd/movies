import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moives/config/app_route/app_routes_name.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/config/theme/text_app.dart';
import 'package:moives/core/utils/widgets/custom_elevated_button.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/cuibt/details_cubit.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/cuibt/details_states.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/widget/cast.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/widget/details_widget.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/widget/genre.dart';
import 'package:moives/features/movies/presentation/pages/movie_details/widget/screen_shots.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({super.key, required this.movieId});

  final int movieId;

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  DetailsCubit cubit = getIt<DetailsCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getMovieDetails(movieId: widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailsCubit, DetailsStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is DetailsLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is DetailsError) {
            return Center(
              child: Text(
                state.message,
                style: TextApp.bold24White,
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is DetailsSuccess) {
            var movie = state.movieDetailsData?.movie;
            final castList = movie?.cast ?? [];
            final genresList = movie?.genres ?? [];
            Widget sectionItem(String sectionName) {
              return Column(
                children: [
                  SizedBox(height: 24.h),
                  Text(sectionName, style: TextApp.bold24White),
                  SizedBox(height: 16.h),
                ],
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 645.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(movie?.largeCoverImage ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          end: AlignmentGeometry.topCenter,
                          begin: AlignmentGeometry.bottomCenter,
                          colors: [
                            ColorApp.black,
                            ColorApp.transparentBlack,
                            ColorApp.transparent,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(
                          top: 30.h,
                          left: 20.w,
                          right: 20.w,
                          bottom: 24.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context.go(AppRoutes.home);
                                  },
                                  icon: SvgPicture.asset(PathImage.back),
                                ),
                                IconButton(
                                  onPressed: () {
                                    //todo: Save movie in profile
                                  },
                                  icon: SvgPicture.asset(PathImage.bookMark),
                                ),
                              ],
                            ),
                            Column(
                              spacing: 18.h,
                              children: [
                                Text(
                                  movie?.title ?? 'No Title',
                                  style: TextApp.bold24White,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${movie?.year ?? '----'}',
                                  style: TextApp.bold20Gray,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomElevatedButton(
                          textStyle: TextApp.bold20White,
                          background: ColorApp.redColor,
                          text: 'Watch',
                          onPressed: () {
                            cubit.watchMovie(movie?.url ?? '');
                          },
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailsWidget(
                              icon: PathImage.favorite,
                              number: movie?.likeCount ?? 0,
                            ),
                            DetailsWidget(
                              icon: PathImage.clock,
                              number: movie?.runtime ?? 0,
                            ),
                            DetailsWidget(
                              icon: PathImage.starRate,
                              number: movie?.rating ?? 0,
                            ),
                          ],
                        ),
                        sectionItem('Screen Shots'),
                        state.screenShots.isEmpty
                            ? Text(
                                "No Screen Shots Available",
                                style: TextApp.regular16White,
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (_, __) => ScreenShotsItem(
                                  screenShotImage: state.screenShots[__],
                                ),
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 12.h),
                                itemCount: state.screenShots.length,
                              ),
                        // todo: add section for Suggestions Movies Here with Suggestions API
                        sectionItem('Summary'),
                        movie?.descriptionFull == null ||
                                movie?.descriptionFull == ""
                            ? Center(child: Text('No Summary Available'))
                            : Text(
                                movie?.descriptionFull ?? '',
                                style: TextApp.regular16White,
                              ),
                        sectionItem('Cast'),
                        castList.isEmpty
                            ? Text(
                                'No Cast Available',
                                style: TextApp.regular16White,
                              )
                            : ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemBuilder: (_, __) {
                                  final cast = castList[__];
                                  return CastItem(
                                    castImage: cast.urlSmallImage ?? '',
                                    castCharacter:
                                        cast.characterName ??
                                        'No Character Name Available',
                                    castName: cast.name ?? 'No Name Available',
                                  );
                                },
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: 12.h),
                                itemCount: castList.length,
                              ),
                        sectionItem('Genres'),
                        genresList.isEmpty
                            ? Text(
                                'No Genre Available',
                                style: TextApp.regular16White,
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 50.h,
                                      mainAxisSpacing: 16.w,
                                      crossAxisSpacing: 16.w,
                                    ),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: genresList.length,
                                itemBuilder: (_, __) {
                                  return GenreItem(genre: genresList[__]);
                                },
                              ),
                        SizedBox(height: 50.h),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
