part of 'auth_form_bloc.dart';

abstract class AuthFormEvent extends Equatable {
  const AuthFormEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends AuthFormEvent {
  final String email;

  const EmailChangedEvent({
    required this.email,
  });

  @override
  List<Object> get props => [
        email,
      ];
}

class PasswordChangedEvent extends AuthFormEvent {
  final String password;

  const PasswordChangedEvent({
    required this.password,
  });

  @override
  List<Object> get props => [
        password,
      ];
}
