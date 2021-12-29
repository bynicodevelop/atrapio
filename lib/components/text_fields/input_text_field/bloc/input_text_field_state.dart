part of 'input_text_field_bloc.dart';

enum StringTextFieldEnum {
  valid,
  invalid,
  undefined,
}

abstract class InputTextFieldState extends Equatable {
  const InputTextFieldState();

  @override
  List<Object> get props => [];
}

class InputTextFieldInitialState extends InputTextFieldState {
  final UniqueKey key;
  final String value;
  final StringTextFieldEnum isValid;

  const InputTextFieldInitialState({
    required this.key,
    this.value = "",
    this.isValid = StringTextFieldEnum.undefined,
  });

  @override
  List<Object> get props => [
        key,
        value,
        isValid,
      ];
}
