import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:horecasmart_task/core/di/dependency_injection.dart';
import 'package:horecasmart_task/features/authentication/login/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = getIt<FirebaseAuth>();
  LoginCubit() : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        UserModel loggedInUser = UserModel(
          uid: user.uid,
          email: user.email ?? email,
          displayName: user.displayName,
          profilePictureUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        );
        emit(LoginState.authenticated(loggedInUser));
      } else {
        emit(const LoginState.unauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'invalid-credential':
          errorMessage = 'The email address or password is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password sign-in is disabled.';
          break;
        case 'email-already-in-use':
          errorMessage = 'This email is already associated with another account.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak. Please choose a stronger password.';
          break;
        default:
          debugPrint("Error during login: ${e.code}");
          errorMessage = 'An unknown error occurred. Please try again later.';
      }
      emit(LoginState.error(errorMessage));
    } catch (e) {
      emit(const LoginState.error('An unexpected error occurred.'));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(const LoginState.initial());
  }
}
