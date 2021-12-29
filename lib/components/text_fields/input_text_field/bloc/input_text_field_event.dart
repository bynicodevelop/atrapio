part of 'input_text_field_bloc.dart';

abstract class InputTextFieldEvent extends Equatable {
  const InputTextFieldEvent();

  @override
  List<Object> get props => [];
}

class OnInputTextFieldChangedEvent extends InputTextFieldEvent {
  final UniqueKey key;
  final String value;

  const OnInputTextFieldChangedEvent({
    required this.key,
    required this.value,
  });

  @override
  List<Object> get props => [
        key,
        value,
      ];
}
