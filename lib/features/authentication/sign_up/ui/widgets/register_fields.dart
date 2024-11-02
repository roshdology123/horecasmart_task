import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/helpers/app_regex.dart';
import 'package:horecasmart_task/core/helpers/spacing.dart';
import 'package:horecasmart_task/core/widgets/main_button.dart';
import 'package:horecasmart_task/core/widgets/main_input_field.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';

class RegisterFields extends StatelessWidget {
  const RegisterFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isButtonEnabled,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isButtonEnabled;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(50),
        MainInputField(label: 'Email', hint: 'johndoe@gmail.com', controller: emailController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email is required';
            }
            if (!value.isValidEmail()) {
              return 'Please enter a valid email';
            }
            return null;
          },),
        verticalSpace(20),
        MainInputField(label: 'Password', hint: '********', controller: passwordController, isPassword: true,
          validator: (value){
            if (value!.isEmpty) {
              return 'Password is required';
            }
            if (!value.isValidPassword()) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },),
        verticalSpace(20),
        MainInputField(label: 'Confirm Password', hint: '********', controller: confirmPasswordController, isPassword: true,
          validator: (value){
            if (value!.isEmpty) {
              return 'Password is required';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },),
        verticalSpace(30),
        MainButton(label: 'Sign Up', isEnabled: isButtonEnabled, onPressed: isButtonEnabled ? () async {
          if (_formKey.currentState!.validate()) {
            await context.read<AuthCubit>().signUp(emailController.text.trim().toLowerCase(), passwordController.text.trim());
          }
        } : (){}),
      ],
    );
  }
}
