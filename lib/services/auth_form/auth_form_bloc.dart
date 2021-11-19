import 'package:atrap_io/validators/email_validator.dart';
import 'package:atrap_io/validators/password_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  AuthFormBloc() : super(const AuthFormState()) {
    on<EmailChangedEvent>((event, emit) {
      final email = EmailValidator.dirty(event.email);

      emit(state.copyWith(
        email: email.valid ? email : EmailValidator.pure(event.email),
        status: Formz.validate([email, state.password]),
      ));
    });

    on<PasswordChangedEvent>((event, emit) {
      final password = PasswordValidator.dirty(event.password);

      emit(state.copyWith(
        password:
            password.valid ? password : PasswordValidator.pure(event.password),
        status: Formz.validate([password, state.email]),
      ));
    });
  }
}
