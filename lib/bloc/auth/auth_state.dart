part of 'auth_bloc.dart';

class AuthState {
  final UserModel? user;
  final StatusEnum status;
  final Exception? error;

  AuthState({this.user, this.status = StatusEnum.initial, this.error});

  factory AuthState.initial() => AuthState();

  AuthState copyWith({UserModel? user, StatusEnum? status, Exception? error}) {
    return AuthState(
      error: error,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

}
