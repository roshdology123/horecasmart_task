import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_state.dart';

import 'widgets/register_fields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool isButtonEnabled = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    emailController.addListener(_checkFormValidity);
    passwordController.addListener(_checkFormValidity);
    confirmPasswordController.addListener(_checkFormValidity);

    super.initState();
  }

  void _checkFormValidity() {
    setState(() {
      isButtonEnabled = emailController.text.isValidEmail() && passwordController.text.isValidPassword() && confirmPasswordController.text == passwordController.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: ColorsManager.pureWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    state.maybeWhen(
      authenticated: (user) {
        context.pushReplacementNamed(Routes.homeScreen);
      },
      error: (message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      },
      orElse: () {},
    );
  },
  child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(30.h),
                Text('Register Account', style: TextStyles.font25BlackBold,),
                verticalSpace(20.h),
                Text('Complete your details', style: TextStyles.font14GrayRegular,),

                RegisterFields(emailController: emailController, passwordController: passwordController, confirmPasswordController: confirmPasswordController, isButtonEnabled: isButtonEnabled, formKey: _formKey),

              ],
            ),
          ),
),
        )
      )
    );
  }
}

