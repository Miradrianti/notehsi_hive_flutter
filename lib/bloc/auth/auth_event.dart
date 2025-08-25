part of 'auth_bloc.dart';

sealed class AuthEvent {}

class RegisterAuthEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterAuthEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  LoginAuthEvent({
    required this.email,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {}