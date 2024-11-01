import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/theming/colors.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:horecasmart_task/core/widgets/main_button.dart';
import 'package:horecasmart_task/core/widgets/main_input_field.dart';

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
      body: SingleChildScrollView(
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
                MainInputField(
                  label: 'Email',
                  hint: 'johndoe@domain.com',
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    if (!value.isValidEmail()) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                verticalSpace(30.h),
                MainInputField(
                  label: 'Password',
                  hint: 'Enter a secure password',
                  controller: passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (!value.isValidPassword()) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                verticalSpace(70.h),
                MainButton(
                    label: 'Sign In',
                    isEnabled: isButtonEnabled,
                    onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleWithHint extends StatelessWidget {
  const TitleWithHint({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220.w,
          child: Text(
            'Welcome back to eCom Mall',
            style: TextStyles.font25BlackBold,
          ),
        ),
        verticalSpace(20.h),
        Text(
          'Login to get the full features of the app',
          style: TextStyles.font14GrayRegular,
        ),
      ],
    );
  }
}
