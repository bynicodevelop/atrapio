import 'dart:developer' as developer;

import 'package:atrap_io/models/user_model.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

enum AppStatus {
  loading,
  loaded,
  authenticated,
  unauthenticated,
}

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthenticationRepository _authenticationRepository;

  AppBloc(
    this._authenticationRepository,
  ) : super(
          const AppState.unauthenticated(),
        ) {
    _authenticationRepository.user.listen((user) {
      add(AppStateChangedEvent(user));
    });

    on<AppStateChangedEvent>((event, emit) {
      developer.log("User: ${event.user.toJson()}");

      emit(event.user.isEmpty
          ? const AppState.unauthenticated()
          : AppState.authenticated(event.user));
    });
  }
}
