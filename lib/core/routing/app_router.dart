import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horecasmart_task/core/di/dependency_injection.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';
import 'package:horecasmart_task/features/authentication/login/ui/login_screen.dart';
import 'package:horecasmart_task/features/authentication/sign_up/ui/sign_up_screen.dart';
import 'package:horecasmart_task/features/cart/data/logic/cubit/cart_cubit.dart';
import 'package:horecasmart_task/features/cart/ui/cart_screen.dart';
import 'package:horecasmart_task/features/home/data/logic/cubit/home_cubit.dart';
import 'package:horecasmart_task/features/home/ui/home_screen.dart';
import 'package:horecasmart_task/features/onboarding/onboarding_screen.dart';
import 'package:horecasmart_task/features/product/data/models/product.dart';
import 'package:horecasmart_task/features/product/ui/product_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<AuthCubit>(),
                  child: const LoginScreen(),
                ));

      case Routes.cartScreen:
        return MaterialPageRoute(
            builder: (_) => const CartScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<AuthCubit>(),
                  child: const SignUpScreen(),
                ));
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<HomeCubit>()..getProducts(),
                  child: const HomeScreen(),
                ));
      case Routes.productDetail:
        if (arguments is Product) {
          final product = arguments;
          return MaterialPageRoute(
            builder: (_) => ProductScreen(product: product),
          );
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for requested route'),
        ),
      ),
    );
  }
}
