part of 'text_field_form_bloc.dart';

abstract class TextFieldFormState extends Equatable {
  const TextFieldFormState();

  @override
  List<Object> get props => [];
}

class TextFieldFormInitialState extends TextFieldFormState {
  final TextFieldFormBlocEnum status;
  final int refresh;

  const TextFieldFormInitialState({
    this.status = TextFieldFormBlocEnum.invalid,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        status,
        refresh,
      ];
}
