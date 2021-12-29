import 'package:formz/formz.dart';

enum StringValidationError { invalid }

class StringValidator extends FormzInput<String, StringValidationError> {
  const StringValidator.pure([String value = '']) : super.pure(value);
  const StringValidator.dirty([String value = '']) : super.dirty(value);

  @override
  StringValidationError? validator(String? value) {
    return value == null || value.isEmpty
        ? StringValidationError.invalid
        : null;
  }
}
