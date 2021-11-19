import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class EmailValidator extends FormzInput<String, EmailValidationError> {
  const EmailValidator.pure([String value = '']) : super.pure(value);
  const EmailValidator.dirty([String value = '']) : super.dirty(value);

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidationError? validator(String? value) {
    return _emailRegex.hasMatch(value ?? '')
        ? null
        : EmailValidationError.invalid;
  }
}
