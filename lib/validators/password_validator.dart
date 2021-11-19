import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class PasswordValidator extends FormzInput<String, PasswordValidationError> {
  const PasswordValidator.pure([String value = '']) : super.pure(value);
  const PasswordValidator.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return (value ?? '').length >= 6 ? null : PasswordValidationError.invalid;
  }
}
