import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/di/dependency_injection.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';
import 'package:horecasmart_task/features/authentication/login/ui/login_screen.dart';
import 'package:horecasmart_task/features/authentication/sign_up/ui/sign_up_screen.dart';
import 'package:horecasmart_task/features/onboarding/onboarding_screen.dart';

class AppRouter {

  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => getIt<AuthCubit>(),
              child: const LoginScreen(),
            ));
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => getIt<AuthCubit>(),
              child:const SignUpScreen(),
            ));
    case Routes.homeScreen:
      return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) =>
            Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}