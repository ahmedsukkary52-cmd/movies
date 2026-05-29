import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/di/di.dart';
import '../../../../../config/theme/path_image.dart';
import '../../../../../config/theme/text_app.dart';
import '../../../../../core/utils/widgets/custom_elevated_button.dart';
import '../../../../../core/utils/widgets/custom_text_field.dart';
import '../../../../../core/validators/validators_app.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController email = TextEditingController();
  final AuthCubit cubit = getIt<AuthCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is AuthForgotPasswordSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Reset email sent!')));
          context.pop();
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(PathImage.forget, width: 430.w, height: 430.h),
                  SizedBox(height: 24.h),
                  CustomTextField(
                    hintText: 'Email',
                    prefixIconName: SvgPicture.asset(PathImage.email),
                    controller: email,
                    validator: ValidatorsApp.validateEmail,
                  ),
                  SizedBox(height: 24.h),
                  BlocBuilder<AuthCubit, AuthStates>(
                    bloc: cubit,
                    builder: (context, state) {
                      return state is AuthLoading
                          ? CircularProgressIndicator()
                          : CustomElevatedButton(
                              text: 'Verify Email',
                              textStyle: TextApp.regular20BlackRoboto,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.forgotPassword(email: email.text);
                                }
                              },
                            );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
