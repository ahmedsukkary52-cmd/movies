import '../../../domain/entities/user.dart';

sealed class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccess extends AuthStates {
  final UserEntity user;

  AuthSuccess({required this.user});
}

class AuthError extends AuthStates {
  final String message;

  AuthError({required this.message});
}

class AuthForgotPasswordSuccess extends AuthStates {}
