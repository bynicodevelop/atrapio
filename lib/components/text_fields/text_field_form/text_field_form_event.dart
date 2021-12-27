part of 'text_field_form_bloc.dart';

abstract class TextFieldFormEvent extends Equatable {
  const TextFieldFormEvent();

  @override
  List<Object> get props => [];
}

class OnTextFieldFormInitializedEvent extends TextFieldFormEvent {
  final Map<String, dynamic> data;

  const OnTextFieldFormInitializedEvent({
    required this.data,
  });

  @override
  List<Object> get props => [
        data,
      ];
}

class OnTextFieldFormEvent extends TextFieldFormEvent {
  final Map<String, dynamic> data;

  const OnTextFieldFormEvent({
    required this.data,
  });

  @override
  List<Object> get props => [
        data,
      ];
}
