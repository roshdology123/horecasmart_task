import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_state.dart';

import 'widgets/input_fields_with_button.dart';
import 'widgets/title_with_hint.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final _formKey = GlobalKey<FormState>();
  bool isButtonEnabled = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(_checkFormValidity);
    passwordController.addListener(_checkFormValidity);
    super.initState();
  }
  void _checkFormValidity() {
    setState(() {
      isButtonEnabled = emailController.text.isValidEmail() && passwordController.text.isValidPassword();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: ColorsManager.pureWhite,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              context.pushReplacementNamed(Routes.homeScreen);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            unauthenticated: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Authentication failed. Please try again.')),
              );
            },
            loading: () {
              setState(() {
                isButtonEnabled = false;
              });
            },
            orElse: () {},
          );
        },
  child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(72.h),
                const TitleWithHint(),
                verticalSpace(50.h),
                InputFieldsWithButton(emailController: emailController, passwordController: passwordController, isButtonEnabled: isButtonEnabled, formKey: _formKey),
              ],
            ),
          ),
        ),
      ),
),
    );
  }
}


