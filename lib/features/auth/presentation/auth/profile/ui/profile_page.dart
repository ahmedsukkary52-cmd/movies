import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moives/core/utils/widgets/shimmer_widgets.dart';

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
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  ProfileCubit cubit = getIt<ProfileCubit>();
  AuthCubit authCubit = getIt<AuthCubit>();
  late TabController _tabController;

  Future<void> _fetchUserData() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!doc.exists) return;

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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<EditProfileCubit, EditProfileStates>(
      bloc: getIt<EditProfileCubit>(),
      listenWhen: (previous, current) => current is EditProfileSuccess,
      listener: (context, state) async {
        _fetchUserData();
      },
      child: BlocBuilder<ProfileCubit, ProfileStates>(
        bloc: cubit,
        buildWhen: (previous, current) {
          return current is ProfileSuccess ||
              current is ProfileError ||
              current is ProfileLoading;
        },
        builder: (context, state) {
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
                  toolbarHeight: 0,
                  expandedHeight: MediaQuery
                      .of(context)
                      .size
                      .height * .40,
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
                                      ? CachedNetworkImage(
                                    imageUrl: state.user.photoUrl!,
                                    width: 118.w,
                                    fit: BoxFit.cover,
                                    memCacheWidth: 300,
                                    placeholder: (context, url) =>
                                    const CircularProgressIndicator(
                                        strokeWidth: 1),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(PathImage.g1, width: 118.w),
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
                                      _StatWidget(
                                        count: '${state.watchlistCount}',
                                        label: 'Wish List',
                                      ),
                                      SizedBox(width: 24.w),
                                      _StatWidget(
                                        count: '${state.historyCount}',
                                        label: 'History',
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
                  state.isLoadingLists
                      ? ProfileGrid()
                      : state.watchlist.isEmpty
                      ? Center(
                          child: Image.asset(PathImage.empty, height: 124.h),
                        )
                      : GridView.builder(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                      bottom: 120.h,
                    ),
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
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 16.h,
                      bottom: 120.h,
                    ),
                    addRepaintBoundaries: true,
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
}

class _StatWidget extends StatelessWidget {
  final String count;
  final String label;

  const _StatWidget({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: TextApp.bold36White),
        Text(label, style: TextApp.bold24White),
      ],
    );
  }
}
