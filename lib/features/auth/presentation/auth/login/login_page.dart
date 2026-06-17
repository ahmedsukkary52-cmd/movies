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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController email;
  late final TextEditingController password;
  final AuthCubit cubit = getIt<AuthCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      bloc: cubit,
      listenWhen: (prev, curr) =>
          curr is AuthSuccess || curr is AuthError && prev != curr,
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
        body: SafeArea(
          child: BlocBuilder<AuthCubit, AuthStates>(
            bloc: cubit,
            buildWhen: (prev, curr) => curr is AuthLoading,
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 69.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(PathImage.logo, width: 121.w, height: 118.h),
                      SizedBox(height: 69.h),
                      CustomTextField(
                        hintText: 'Email',
                        prefixIconName: SvgPicture.asset(PathImage.email),
                        controller: email,
                        validator: ValidatorsApp.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 22.h),
                      CustomTextField(
                        hintText: 'Password',
                        prefixIconName: SvgPicture.asset(PathImage.password),
                        controller: password,
                        validator: ValidatorsApp.validatePassword,
                        obscureText: true,
                        hasSuffix: true,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                context.push(AppRoutes.forgotPassword),
                            child: Text(
                              'Forgot Password?',
                              style: TextApp.regular14Wallow,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),
                      state is AuthLoading
                          ? const CircularProgressIndicator()
                          : CustomElevatedButton(
                              text: 'Login',
                              textStyle: TextApp.regular20BlackRoboto,
                              onPressed: () {
                                final isValid =
                                    _formKey.currentState?.validate() ?? false;
                                if (!isValid) return;
                                cubit.login(
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                );
                              },
                            ),
                      SizedBox(height: 22.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have Account?",
                            style: TextApp.regular14White,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 4.w),
                              alignment: Alignment.centerLeft,
                            ),
                            onPressed: () => context.push(AppRoutes.register),
                            child: Text("Create", style: TextApp.black14Wallow),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: ColorApp.primary,
                              endIndent: 11.w,
                              indent: 70.w,
                            ),
                          ),
                          Text('OR', style: TextApp.regular15Primary),
                          Expanded(
                            child: Divider(
                              color: ColorApp.primary,
                              endIndent: 70.w,
                              indent: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 28.h),
                      CustomElevatedButton(
                        text: 'Login With Google',
                        textStyle: TextApp.regular20BlackRoboto,
                        hasIcon: true,
                        onPressed: () => cubit.loginWithGoogle(),
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
