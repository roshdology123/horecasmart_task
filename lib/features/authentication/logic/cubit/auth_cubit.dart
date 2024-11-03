import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:horecasmart_task/core/di/dependency_injection.dart';
import 'package:horecasmart_task/features/authentication/login/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = getIt<FirebaseAuth>();
  final FirebaseFirestore _firebaseFirestore;
  AuthCubit(this._firebaseFirestore) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(const AuthState.loading());
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
        emit(AuthState.authenticated(loggedInUser));
      } else {
        emit(const AuthState.unauthenticated());
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
          errorMessage =
              'This email is already associated with another account.';
          break;
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please choose a stronger password.';
          break;
        default:
          debugPrint("Error during login: ${e.code}");
          errorMessage = 'An unknown error occurred. Please try again later.';
      }
      emit(AuthState.error(errorMessage));
    } catch (e) {
      emit(const AuthState.error('An unexpected error occurred.'));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    emit(const AuthState.initial());
  }

  Future<void> signUp(String email, String password) async {
    try {
      emit(const AuthState.loading());
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null) {
        UserModel newUser = UserModel(
          uid: user.uid,
          email: user.email ?? email,
          displayName: user.displayName,
          profilePictureUrl: user.photoURL,
          phoneNumber: user.phoneNumber,
        );
        await _firebaseFirestore.collection('users').doc(user.uid).set(newUser.toJson());
        emit(AuthState.authenticated(newUser));
      } else {
        emit(const AuthState.error('An error occurred. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'This email is already associated with another account.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password sign-in is disabled.';
          break;
        case 'weak-password':
          errorMessage = 'The password is too weak.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      emit(AuthState.error(errorMessage));
    }
  }

}
