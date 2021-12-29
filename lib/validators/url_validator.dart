import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum UrlValidationError { invalid }

class UrlValidator extends FormzInput<String, UrlValidationError> {
  const UrlValidator.pure([String value = '']) : super.pure(value);
  const UrlValidator.dirty([String value = '']) : super.dirty(value);

  @override
  UrlValidationError? validator(String? value) {
    return isURL(value ?? "") ? null : UrlValidationError.invalid;
  }
}
