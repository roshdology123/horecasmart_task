import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:horecasmart_task/features/authentication/logic/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerFactory<AuthCubit>(() => AuthCubit());
}