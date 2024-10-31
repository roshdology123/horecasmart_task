import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horecasmart_task/core/routing/app_router.dart';
import 'package:horecasmart_task/horecasmart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(HorecasmartApp(appRouter: AppRouter()));
}