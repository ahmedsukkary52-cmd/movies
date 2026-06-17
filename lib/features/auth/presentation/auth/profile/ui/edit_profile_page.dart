import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moives/config/theme/color_app.dart';
import 'package:moives/config/theme/path_image.dart';
import 'package:moives/config/theme/text_app.dart';
import 'package:moives/core/utils/widgets/custom_elevated_button.dart';
import 'package:moives/core/utils/widgets/custom_text_field.dart';
import 'package:moives/core/validators/validators_app.dart';

import '../../../../../../config/app_route/app_routes_name.dart';
import '../../../../../../config/di/di.dart';
import '../cubit/edit_profile_cubit/edit_profile_cubit.dart';
import '../cubit/edit_profile_cubit/edit_profile_states.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    this.name,
    this.phone,
    this.avatar,
    required this.email,
  });

  final String? name;
  final String? phone;
  final String? avatar;
  final String? email;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController name;
  late TextEditingController phone;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.name ?? '');
    phone = TextEditingController(text: widget.phone ?? '');
    _selectedIndex = avatars.indexOf(widget.avatar ?? PathImage.g1);
    if (_selectedIndex == -1) _selectedIndex = 0;
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  EditProfileCubit cubit = getIt<EditProfileCubit>();
  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  final List<String> avatars = [
    PathImage.g1,
    PathImage.g2,
    PathImage.g3,
    PathImage.g4,
    PathImage.g5,
    PathImage.g6,
    PathImage.g7,
    PathImage.g8,
    PathImage.g9,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully!')),
          );
          context.pop();
        } else if (state is DeleteAccountSuccess) {
          context.go(AppRoutes.login);
        } else if (state is EditProfileError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorApp.primary,
            ),
          ),
          toolbarHeight: 60,
          title: Text('Edit Profile', style: TextApp.regular16Wallow),
        ),
        body: BlocBuilder<EditProfileCubit, EditProfileStates>(
          bloc: cubit,
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _showAvatarPicker,
                          child: Image.asset(
                            avatars[_selectedIndex],
                            height: 150.h,
                          ),
                        ),
                        SizedBox(height: 35.h),
                        CustomTextField(
                          hintText: 'Name',
                          prefixIconName: SvgPicture.asset(PathImage.name),
                          controller: name,
                          validator: ValidatorsApp.validateFullName,
                        ),
                        SizedBox(height: 18.h),
                        CustomTextField(
                          hintText: 'Phone',
                          prefixIconName: SvgPicture.asset(PathImage.phone),
                          controller: phone,
                          validator: ValidatorsApp.validatePhoneNumber,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => context.push(
                                AppRoutes.forgotPassword,
                                extra: {'email': widget.email},
                              ),
                              child: Text(
                                'Reset Password',
                                style: TextApp.regular20White,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 250.h),
                        state is EditProfileLoading
                            ? CircularProgressIndicator()
                            : Column(
                                children: [
                                  CustomElevatedButton(
                                    text: 'Delete Account',
                                    onPressed: () => _showDeleteDialog(),
                                    background: ColorApp.redColor,
                                    textStyle: TextApp.regular20White,
                                  ),
                                  SizedBox(height: 18.h),
                                  CustomElevatedButton(
                                    text: 'Update Data',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user != null) {
                                          cubit.updateProfile(
                                            userId: user.uid,
                                            name: name.text,
                                            phone: phone.text,
                                            avatar: avatars[_selectedIndex],
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorApp.grayColor,
        title: Text('Delete Account', style: TextApp.bold24White),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your password to confirm',
              style: TextApp.regular16White,
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: TextApp.regular16White,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextApp.regular20Wallow),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                cubit.deleteAccount(
                  userId: user.uid,
                  password: passwordController.text.trim(),
                );
              }
            },
            child: Text('Delete', style: TextApp.regular20White),
          ),
        ],
      ),
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorApp.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
            decoration: BoxDecoration(
              color: ColorApp.grayColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12.w,
                  crossAxisSpacing: 12.w,
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      if (_selectedIndex == index) return;
                      setState(() => _selectedIndex = index);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsetsGeometry.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? ColorApp.primary
                              : ColorApp.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(avatars[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
