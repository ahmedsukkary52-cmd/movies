import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moives/config/di/di.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/core/utils/widgets/custom_text_field.dart';
import 'package:moives/core/utils/widgets/movie_item.dart';
import 'package:moives/features/movies/presentation/pages/search/cubit/search_cubit.dart';
import 'package:moives/features/movies/presentation/pages/search/cubit/search_states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchCubit cubit = getIt<SearchCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getInitialMovie();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchStates>(
        bloc: cubit,
        builder: (context, state) {
          final movies = state is SearchSuccess
              ? (state).movie
              : cubit.currentMovies;

          if (state is SearchLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          } else if (state is SearchLoadingMore || state is SearchSuccess) {
            return SafeArea(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 22.h),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Search Here',
                    prefixIconName: SvgPicture.asset(PathImage.search),
                    onSubmitted: (text) => cubit.searchImmediate(text),
                    onChange: (text) => cubit.search(text),
                    textInputAction: TextInputAction.search,
                  ),
                  SizedBox(height: 5.h,),
                  movies.isEmpty ?
                  Expanded(child: Center(child: Image.asset(
                    PathImage.empty, height: 124.h, width: 124.w,))) :
                  Expanded(
                    child: Stack(
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.only(top: 70.h),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20.w,
                            mainAxisExtent: 260.h,
                            crossAxisSpacing: 20.w,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return MovieItem(
                              movie: movies[index],
                              isSmall: true,
                            );
                          },
                        ),
                        ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 15,
                              sigmaY: 15,
                            ),
                            child: Container(
                              height: 60.h,
                              color: ColorApp.black.withOpacity(.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
