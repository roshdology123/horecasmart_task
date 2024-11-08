import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/routing/app_router.dart';
import 'package:horecasmart_task/core/routing/routes.dart';
import 'package:horecasmart_task/core/theming/colors.dart';

class HorecasmartApp extends StatelessWidget {
  final AppRouter appRouter;
  const HorecasmartApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child : MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Horecasmart',
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.loginScreen,
        theme: ThemeData(
          primaryColor: ColorsManager.primaryBlueOceanColor,
          scaffoldBackgroundColor: ColorsManager.pureWhite,
        ),
      ),
    );
  }
}
