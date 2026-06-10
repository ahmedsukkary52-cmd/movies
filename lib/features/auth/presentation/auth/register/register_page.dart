import 'package:carousel_slider/carousel_slider.dart';
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

import '../../../../../config/app_route/app_routes_name.dart';
import '../../../../../config/di/di.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController name = TextEditingController(
    text: 'Ahmed Adel Elsukkary',
  );
  final TextEditingController email = TextEditingController(
    text: 'ahmedadel2009@gmail.com',
  );
  final TextEditingController password = TextEditingController(
    text: "Ahmed@2009",
  );
  final TextEditingController confirmPassword = TextEditingController(
    text: "Ahmed@2009",
  );
  final TextEditingController phone = TextEditingController(
    text: '01080875641',
  );
  final AuthCubit cubit = getIt<AuthCubit>();
  final _formKey = GlobalKey<FormState>();
  int _selectedAvatarIndex = 0;

  final List<String> avatar = [
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
    return BlocListener<AuthCubit, AuthStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRoutes.main);
        } else if (state is AuthError) {
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
          title: Text('Register', style: TextApp.regular16Wallow),
        ),
        body: SafeArea(
          child: BlocBuilder<AuthCubit, AuthStates>(
            bloc: cubit,
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: avatar.length,
                        itemBuilder: (context, index, realIndex) {
                          return Image.asset(avatar[index]);
                        },
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          viewportFraction: .38,
                          enlargeFactor: .5,
                          aspectRatio: 2,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _selectedAvatarIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          spacing: 24.h,
                          children: [
                            CustomTextField(
                              hintText: 'Full Name',
                              validator: ValidatorsApp.validateFullName,
                              prefixIconName: SvgPicture.asset(PathImage.name),
                              controller: name,
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              validator: ValidatorsApp.validateEmail,
                              prefixIconName: SvgPicture.asset(PathImage.email),
                              controller: email,
                            ),
                            CustomTextField(
                              hintText: 'Password',
                              validator: ValidatorsApp.validatePassword,
                              prefixIconName: SvgPicture.asset(
                                PathImage.password,
                              ),
                              controller: password,
                              obscureText: true,
                              hasSuffix: true,
                            ),
                            CustomTextField(
                              hintText: 'Confirm Password',
                              validator: (val) =>
                                  ValidatorsApp.validateConfirmPassword(
                                    val,
                                    password.text,
                                  ),
                              obscureText: true,
                              prefixIconName: SvgPicture.asset(
                                PathImage.password,
                              ),
                              controller: confirmPassword,
                              hasSuffix: true,
                            ),
                            CustomTextField(
                              hintText: 'Phone',
                              validator: ValidatorsApp.validatePhoneNumber,
                              prefixIconName: SvgPicture.asset(PathImage.phone),
                              controller: phone,
                              isNumber: true,
                            ),
                            state is AuthLoading
                                ? CircularProgressIndicator()
                                : CustomElevatedButton(
                                    text: 'Create Account',
                                    textStyle: TextApp.regular20BlackRoboto,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.register(
                                          email: email.text,
                                          password: password.text,
                                          name: name.text,
                                          phone: phone.text,
                                          avatar: avatar[_selectedAvatarIndex],
                                        );
                                      }
                                    },
                                  ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have Account?',
                            style: TextApp.regular14White,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 5.w),
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () => context.pop(),
                            child: Text('Login', style: TextApp.black14Wallow),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
