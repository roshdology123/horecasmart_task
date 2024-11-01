import 'package:flutter/widgets.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";

  bool isValidEmail() {
    if (isNullOrEmpty()) return false;
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(this!);
  }

  bool isValidPhone() {
    if (isNullOrEmpty()) return false;
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    return phoneRegex.hasMatch(this!);
  }

  bool isValidPassword({int minLength = 6}) {
    if (isNullOrEmpty()) return false;
    return this!.length >= minLength;
  }
}
