part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String error;

  const LoginFailureState(
    this.error,
  );

  @override
  List<Object> get props => [
        error,
      ];

  @override
  String toString() => 'RegisterFailedState { error: $error }';
}
