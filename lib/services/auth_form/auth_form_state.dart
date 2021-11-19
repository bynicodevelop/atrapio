part of 'auth_form_bloc.dart';

class AuthFormState extends Equatable {
  final EmailValidator email;
  final PasswordValidator password;
  final FormzStatus status;

  const AuthFormState({
    this.email = const EmailValidator.pure(),
    this.password = const PasswordValidator.pure(),
    this.status = FormzStatus.pure,
  });

  AuthFormState copyWith({
    EmailValidator? email,
    PasswordValidator? password,
    FormzStatus? status,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        status,
      ];
}
