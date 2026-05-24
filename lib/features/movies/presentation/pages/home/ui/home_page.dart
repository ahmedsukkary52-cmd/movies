import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/config/theme/text_app.dart';
import 'package:moives/core/utils/widgets/movie_item.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/states.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/view_model.dart';

import '../../bottom_nav/cubit/bottom_nav_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit cubit = getIt<HomeCubit>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await cubit.getMoviesList();
    await cubit.getMoviesByGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeError) {
            return Center(child: Text(state.message, style: TextApp.bold24White,
              textAlign: TextAlign.center,));
          }
          if (state is HomeSuccess) {
            return Container(
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
                          enlargeCenterPage: true,
                          viewportFraction: .58,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          enlargeFactor: .4,
                          autoPlay: true,
                          onPageChanged: (index, reason) {
                            if (index >= state.movie.length - 3 &&
                                !state.isLoadingMore) {
                              cubit.getMoviesList(isLoadMore: true);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 150.h),
                      if (state.isLoadingGenre)
                        Center(child: CircularProgressIndicator())
                      else
                        ...state.moviesByGenre.entries.map((entry) {
                          return Padding(
                            padding: EdgeInsets.only(left: 16.w, bottom: 30.h),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                        entry.key,
                                        style: TextApp.regular20White),
                                    TextButton(onPressed: () {
                                      context
                                          .read<BottomNavCubit>()
                                          .selectGenre(entry.key);
                                      context.read<BottomNavCubit>().changeTab(
                                          2);
                                    },
                                        child: Text('See More',
                                            style: TextApp.regular16Wallow)),
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
                        }),
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
