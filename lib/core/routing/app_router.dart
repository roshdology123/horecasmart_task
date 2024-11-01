import 'package:flutter/material.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/features/authentication/login/login_screen.dart';
import 'package:horecasmart_task/features/onboarding/onboarding_screen.dart';

class AppRouter{

  Route generateRoute(RouteSettings settings){

    final arguments = settings.arguments;

    switch(settings.name){
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case Routes.registerScreen:
      //   return MaterialPageRoute(builder: (_) => RegisterScreen());
      // case Routes.homeScreen:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ));
    }
  }
}