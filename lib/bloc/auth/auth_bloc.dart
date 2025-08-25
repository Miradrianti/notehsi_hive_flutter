import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enum/status_enum.dart';
import '../../model/user_model.dart';
import '../../service/user/local_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<RegisterAuthEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        final user = await UserLocalService.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: StatusEnum.success, user: user));
      } on Exception catch (e) {
        emit(state.copyWith(status: StatusEnum.failure, error: e));
      }
    });

    on<LoginAuthEvent>((event, emit) async {
      try {
        emit(state.copyWith(status: StatusEnum.loading));

        final user = await UserLocalService.login(
          email: event.email,
          password: event.password,
        );

        emit(state.copyWith(status: StatusEnum.success, user: user));
      } on Exception catch (e) {
        emit(state.copyWith(
          status: StatusEnum.failure, 
          error: e,
        ));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(state.copyWith(status: StatusEnum.initial, user: null, error: null));
      await UserLocalService.logout();
    });
    
  }
}