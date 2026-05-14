import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/states.dart';
import 'package:moives/features/movies/presentation/pages/home/cubit/view_model.dart';
import 'package:moives/features/movies/presentation/pages/home/widget/movie_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeCubit cubit = getIt<HomeCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else if (state is HomeSuccess) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(PathImage.homeBg),
                  alignment: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 122.h),
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
