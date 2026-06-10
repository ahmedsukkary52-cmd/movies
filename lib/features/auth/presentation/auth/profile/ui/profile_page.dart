import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/app_route/app_routes_name.dart';
import '../../../../../../config/di/di.dart';
import '../../../../../../config/theme/color_app.dart';
import '../../../../../../config/theme/path_image.dart';
import '../../../../../../config/theme/text_app.dart';
import '../../../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../../../core/utils/widgets/movie_item.dart';
import '../../../../domain/entities/user.dart';
import '../../cubit/auth_cubit.dart';
import '../cubit/edit_profile_cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_cubit/edit_profile_states.dart';
import '../cubit/profile_cubit/profile_cubit.dart';
import '../cubit/profile_cubit/profile_states.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  ProfileCubit cubit = getIt<ProfileCubit>();
  AuthCubit authCubit = getIt<AuthCubit>();
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((doc) {
            if (doc.exists) {
              cubit.getProfile(
                UserEntity(
                  id: firebaseUser.uid,
                  email: firebaseUser.email!,
                  name: doc.data()?['name'],
                  photoUrl: doc.data()?['avatar'],
                  phone: doc.data()?['phone'],
                ),
              );
            }
          });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileStates>(
      bloc: getIt<EditProfileCubit>(),
      listener: (context, state) async {
        if (state is EditProfileSuccess) {
          final firebaseUser = FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            final doc = await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get();
            if (doc.exists) {
              cubit.getProfile(
                UserEntity(
                  id: firebaseUser.uid,
                  email: firebaseUser.email!,
                  name: doc.data()?['name'],
                  photoUrl: doc.data()?['avatar'],
                  phone: doc.data()?['phone'],
                ),
              );
            }
          }
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return Center(
              child: Text(state.message, style: TextApp.bold24White),
            );
          }
          if (state is ProfileSuccess) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * .45,
                  backgroundColor: ColorApp.grayColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.only(
                        right: 16.w,
                        left: 16.w,
                        top: 70.h,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  state.user.photoUrl != null
                                      ? Image.asset(
                                          state.user.photoUrl!,
                                          width: 118.w,
                                        )
                                      : Image.asset(PathImage.g1, width: 118.w),
                                  SizedBox(height: 12.h),
                                  SizedBox(
                                    width: 120.w,
                                    child: Text(
                                      state.user.name ?? 'User',
                                      style: TextApp.bold20White,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 16.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      _statWidget(
                                        '${state.watchlistCount}',
                                        'Wish List',
                                      ),
                                      SizedBox(width: 24.w),
                                      _statWidget(
                                        '${state.historyCount}',
                                        'History',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomElevatedButton(
                                  text: 'Edit Profile',
                                  textStyle: TextApp.regular20BlackRoboto,
                                  onPressed: () async {
                                    context.push(
                                      AppRoutes.editProfile,
                                      extra: {
                                        'name': state.user.name,
                                        'phone': state.user.phone,
                                        'avatar': state.user.photoUrl,
                                        'email': state.user.email,
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                flex: 1,
                                child: CustomElevatedButton(
                                  hasIcon: true,
                                  customWidgetWithIcon: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 8.w,
                                    children: [
                                      Text(
                                        'Exit',
                                        style: TextApp.regular20White,
                                      ),
                                      SvgPicture.asset(PathImage.exit),
                                    ],
                                  ),
                                  text: '',
                                  background: ColorApp.redColor,
                                  onPressed: () async {
                                    await authCubit.logout();
                                    context.go(AppRoutes.login);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: ColorApp.primary,
                    labelColor: ColorApp.primary,
                    unselectedLabelColor: ColorApp.whiteColor,
                    dividerColor: ColorApp.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextApp.regular20White,
                    tabs: [
                      Tab(
                        icon: Icon(
                          Icons.format_list_bulleted_rounded,
                          size: 40.w,
                        ),
                        text: 'Watch List',
                        height: 100,
                      ),
                      Tab(
                        icon: Icon(Icons.folder, size: 40.w),
                        text: 'History',
                      ),
                    ],
                  ),
                ),
              ],
              body: TabBarView(
                controller: _tabController,
                children: [
                  state.watchlist.isEmpty
                      ? Center(
                          child: Image.asset(PathImage.empty, height: 124.h),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.all(16.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15.w,
                                mainAxisExtent: 210.h,
                                crossAxisSpacing: 15.w,
                              ),
                          itemCount: state.watchlist.length,
                          itemBuilder: (context, index) {
                            return MovieItem(
                              movie: state.watchlist[index],
                              isSmall: true,
                            );
                          },
                        ),
                  state.history.isEmpty
                      ? Center(
                          child: Image.asset(PathImage.empty, height: 124.h),
                        )
                      : GridView.builder(
                          padding: EdgeInsets.all(16.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 15.w,
                                mainAxisExtent: 210.h,
                                crossAxisSpacing: 15.w,
                              ),
                          itemCount: state.history.length,
                          itemBuilder: (context, index) {
                            return MovieItem(
                              movie: state.history[index],
                              isSmall: true,
                            );
                          },
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

  Widget _statWidget(String count, String label) {
    return Column(
      spacing: 10.h,
      children: [
        Text(count, style: TextApp.bold36White),
        Text(label, style: TextApp.bold24White),
      ],
    );
  }
}
