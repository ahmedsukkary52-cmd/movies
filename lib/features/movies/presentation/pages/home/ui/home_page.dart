import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/config/theme/text_app.dart';
import 'package:moives/core/utils/widgets/movie_item.dart';
import 'package:moives/core/utils/widgets/shimmer_widgets.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/home_cubit.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/states.dart';

import '../../../../../../core/utils/widgets/error_widget.dart';
import '../../bottom_nav/cubit/bottom_nav_cubit.dart';
import '../cubit/genre_section_cubit/genre_sections_cubit.dart';
import '../cubit/genre_section_cubit/genre_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit cubit = getIt<HomeCubit>();
  GenreSectionsCubit genreCubit = getIt<GenreSectionsCubit>();

  void _init() {
    cubit.getMoviesList();
    genreCubit.getMoviesByGenre();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
        bloc: cubit,
        buildWhen: (prev, curr) =>
        curr is HomeLoading || curr is HomeSuccess || curr is HomeError,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeShimmer();
          }
          if (state is HomeError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                cubit.getMoviesList();
                genreCubit.getMoviesByGenre();
              },
            );
          }
          if (state is HomeSuccess) {
            return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(PathImage.homeBg),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    children: [
                      SizedBox(height: 130.h),
                      CarouselSlider.builder(
                        itemCount: state.movie.length,
                        itemBuilder: (context, index, realIndex) {
                          final movie = state.movie[index];
                          return MovieItem(movie: movie, isSmall: false);
                        },
                        options: CarouselOptions(
                          height: 352.h,
                          pauseAutoPlayOnTouch: true,
                          enlargeCenterPage: true,
                          pageSnapping: true,
                          viewportFraction: .58,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeFactor: .4,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            cubit.handlePagination(index);
                          },
                        ),
                      ),
                      SizedBox(height: 150.h),
                      BlocBuilder<GenreSectionsCubit, GenreSectionsStates>(
                        bloc: genreCubit,
                        builder: (context, genreState) {
                          if (genreState is GenreSectionsLoading) {
                            return const GenreSectionShimmer();
                          }
                          if (genreState is GenreSectionsSuccess) {
                            return Column(
                              children: genreState.moviesByGenre.entries.map((
                                  entry) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.w, bottom: 30.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(entry.key,
                                              style: TextApp.regular20White),
                                          TextButton(
                                            onPressed: () {
                                              context
                                                  .read<BottomNavCubit>()
                                                  .selectGenre(entry.key);
                                              context
                                                  .read<BottomNavCubit>()
                                                  .changeTab(2);
                                            },
                                            child: Text('See More',
                                                style: TextApp.regular16Wallow),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.h),
                                      SizedBox(
                                        height: 220.h,
                                        child: ListView.separated(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(width: 20.w),
                                          itemCount: entry.value.length,
                                          itemBuilder: (context, index) {
                                            return MovieItem(
                                              movie: entry.value[index],
                                              isSmall: true,
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}