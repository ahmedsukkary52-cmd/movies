import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moives/features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_cubit.dart';
import 'package:moives/features/movies/presentation/pages/bottom_nav/cubit/bottom_nav_state.dart';
import 'package:moives/features/movies/presentation/pages/home/ui/home_page.dart';

import '../../../../../../config/di/di.dart';
import '../../../../../auth/domain/entities/user.dart';
import '../../../../../auth/presentation/auth/profile/cubit/profile_cubit/profile_cubit.dart';
import '../../../../../auth/presentation/auth/profile/ui/profile_page.dart';
import '../../browse/cubit/browse_cubit.dart';
import '../../browse/ui/browse_page.dart';
import '../../home/cubit/view_model.dart';
import '../../search/cubit/search_cubit.dart';
import '../../search/ui/search_page.dart';
import '../widget/custom_bottom_nav.dart';

class MainScreenBottomNav extends StatefulWidget {
  const MainScreenBottomNav({super.key});

  @override
  State<MainScreenBottomNav> createState() => _MainScreenBottomNavState();
}

class _MainScreenBottomNavState extends State<MainScreenBottomNav> {
  late StreamSubscription _connectivitySubscription;
  final cubit = getIt<BottomNavCubit>();
  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        getIt<HomeCubit>().getMoviesList();
        getIt<SearchCubit>().getInitialMovie();
        getIt<BrowseCubit>().getMoviesByGenre(
            getIt<BottomNavCubit>().state.selectedGenre ?? 'Action'
        );
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  final List<Widget> screens = [
    HomePage(),
    SearchPage(),
    BrowsePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {
        if (state.currentIndex == 3) {
          final profileCubit = getIt<ProfileCubit>();
          final firebaseUser = FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get()
                .then((doc) {
              if (doc.exists) {
                profileCubit.getProfile(UserEntity(
                  id: firebaseUser.uid,
                  email: firebaseUser.email!,
                  name: doc.data()?['name'],
                  photoUrl: doc.data()?['avatar'],
                  phone: doc.data()?['phone'],
                ));
              }
            });
          }
        }
      },
      child: BlocBuilder<BottomNavCubit, BottomNavStates>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
      ),
    );
  }
}
