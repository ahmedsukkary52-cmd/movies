import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/text_app.dart';
import 'package:moives/features/movies/presentation/pages/browse/cubit/browse_cubit.dart';
import 'package:moives/features/movies/presentation/pages/browse/cubit/browse_states.dart';
import 'package:moives/features/movies/presentation/pages/browse/widget/genre_item.dart';

import '../../../../../../config/theme/color_app.dart';
import '../../../../../../core/utils/widgets/movie_item.dart';
import '../../bottom_nav/cubit/bottom_nav_cubit.dart';
import '../../bottom_nav/cubit/bottom_nav_state.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key,});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  BrowseCubit cubit = getIt<BrowseCubit>();
  ScrollController _scrollController = ScrollController();
  String? _lastGenre;
  bool _isFetching = false;
  final List<String> genres = [
    'Action',
    'Comedy',
    'Horror',
    'Drama',
    'Romance',
  ];

  @override
  void initState() {
    super.initState();
    cubit.getMoviesByGenre('Action');
    _scrollController.addListener(() {
      if (!_isFetching &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 500) {
        final currentState = cubit.state;
        if (currentState is SuccessBrowse) {
          _isFetching = true;
          cubit.getMoviesByGenre(currentState.selectedGenre, isLoadMore: true)
              .then((_) => _isFetching = false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavCubit, BottomNavStates>(
        listener: (context, navState) {
          if (navState.selectedGenre != null &&
              navState.selectedGenre != _lastGenre) {
            _lastGenre = navState.selectedGenre;
            cubit.getMoviesByGenre(navState.selectedGenre!);
          }
        },
        child: Scaffold(
          body: BlocBuilder<BrowseCubit, BrowseStates>(
            bloc: cubit,
            builder: (context, state) {
              if (state is LoadingBrowse) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ErrorBrowse) {
                return Center(
                  child: Text(state.message, style: TextApp.regular16White),
                );
              }
              if (state is SuccessBrowse) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80.h,
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 20.h),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 12.w,),
                            scrollDirection: Axis.horizontal,
                            itemCount: genres.length,
                            itemBuilder: (context, index) {
                              final genre = genres[index];
                              return GenreWidget(
                                isSelected: genre == state.selectedGenre,
                                genreName: genre,
                                onTap: () => cubit.getMoviesByGenre(genre),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              GridView.builder(
                                padding: EdgeInsets.only(top: 30.h),
                                controller: _scrollController,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20.w,
                                  mainAxisExtent: 260.h,
                                  crossAxisSpacing: 20.w,
                                ),
                                itemCount: state.movies.length,
                                itemBuilder: (context, index) {
                                  return MovieItem(
                                    movie: state.movies[index],
                                    isSmall: true,
                                  );
                                },
                              ),
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 15, sigmaY: 15),
                                  child: Container(
                                    height: 20.h,
                                    color: ColorApp.black.withOpacity(.9),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        )
    );
  }
}
