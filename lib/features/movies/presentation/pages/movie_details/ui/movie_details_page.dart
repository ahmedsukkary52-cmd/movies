import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

import '../../../../../../core/utils/widgets/movie_item.dart';

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
    cubit.getMovieSuggestions(movieId: widget.movieId);
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

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 645.h,
                  backgroundColor: Colors.black,

                  leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: SvgPicture.asset(PathImage.back),
                  ),

                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(PathImage.bookMark),
                    ),
                  ],

                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        /// الصورة
                        Image.network(
                          movie?.largeCoverImage ?? '',
                          fit: BoxFit.cover,
                        ),

                        /// الجريدينت
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black,
                                Colors.black54,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        /// الكلام
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            bottom: 40.h,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  movie?.title ?? '',
                                  style: TextApp.bold24White,
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 12.h),

                                Text(
                                  '${movie?.year ?? ''}',
                                  style: TextApp.bold20Gray,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              sectionItem('Similar'),
                              state.suggestions.isEmpty
                                  ? Text(
                                      'No Similar Movies Available',
                                      style: TextApp.regular16White,
                                    )
                                  : GridView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 20.w,
                                            mainAxisExtent: 260.h,
                                            crossAxisSpacing: 20.w,
                                          ),
                                      itemCount: state.suggestions.length,
                                      itemBuilder: (context, index) {
                                        return MovieItem(
                                          movie: state.suggestions[index],
                                          isSmall: true,
                                        );
                                      },
                                    ),
                              sectionItem('Summary'),
                              movie?.descriptionFull == null ||
                                      movie?.descriptionFull == ""
                                  ? Text('No Summary Available')
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
                                          castName:
                                              cast.name ?? 'No Name Available',
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
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
