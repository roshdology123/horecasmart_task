part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.authenticated(UserModel user) = _Authenticated;
  const factory LoginState.unauthenticated() = _Unauthenticated;
  const factory LoginState.error(String message) = _Error;
}
