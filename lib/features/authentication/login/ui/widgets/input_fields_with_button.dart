import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/styles.dart';
import 'package:horecasmart_task/core/widgets/main_button.dart';
import 'package:horecasmart_task/core/widgets/main_input_field.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';

class InputFieldsWithButton extends StatelessWidget {
  const InputFieldsWithButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isButtonEnabled,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isButtonEnabled;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        verticalSpace(30),
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
        verticalSpace(70),
        MainButton(
          label: 'Sign In',
          isEnabled: isButtonEnabled,
          onPressed: isButtonEnabled ? () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().login(emailController.text.trim().toLowerCase(), passwordController.text.trim());
            }
          } : (){

          },
        ),
        verticalSpace(60),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){}, child: Text('Forgot Password?', style: TextStyles.font14BlackRegular)),
            TextButton(onPressed: (){
              context.pushNamed(Routes.signUpScreen);
            }, child: Text('Sign Up', style: TextStyles.font13BlueRegular)),
          ],
        ),
      ],
    );
  }
}
