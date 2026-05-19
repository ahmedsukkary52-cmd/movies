import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moives/features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:moives/features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_state.dart';
import 'package:moives/features/movies/presentation/pages/home/ui/home_page.dart';
import 'package:moives/features/movies/presentation/pages/profile/ui/profile_page.dart';

import '../../brows/ui/brows_page.dart';
import '../../search/ui/search_page.dart';
import '../widget/custom_bottom_nav.dart';

class MainScreenBottomNav extends StatelessWidget {
  MainScreenBottomNav({super.key});

  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    BrowsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: IndexedStack(
                  index: state.currentIndex,
                  children: screens,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: CustomBottomNavBar(
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    context.read<BottomNavCubit>().changeTab(index);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
