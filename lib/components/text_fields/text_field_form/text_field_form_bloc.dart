import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'text_field_form_event.dart';
part 'text_field_form_state.dart';

enum TextFieldFormBlocEnum {
  valid,
  invalid,
}

class TextFieldFormBloc extends Bloc<TextFieldFormEvent, TextFieldFormState> {
  Map<String, dynamic> _formData = {};

  TextFieldFormBloc() : super(const TextFieldFormInitialState()) {
    on<OnTextFieldFormInitializedEvent>((event, emit) {
      _formData = event.data;

      final bool hasError = _formData.entries
          .where(
            (field) => field.value == TextFieldFormBlocEnum.invalid,
          )
          .isNotEmpty;

      emit(
        TextFieldFormInitialState(
          status: hasError
              ? TextFieldFormBlocEnum.invalid
              : TextFieldFormBlocEnum.valid,
          refresh: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });

    on<OnTextFieldFormEvent>((event, emit) {
      _formData = {
        ..._formData,
        ...event.data,
      };

      final bool hasError = _formData.entries
          .where(
            (field) =>
                field.value == TextFieldFormBlocEnum.invalid ||
                field.value == true,
          )
          .isNotEmpty;

      emit(
        TextFieldFormInitialState(
          status: hasError
              ? TextFieldFormBlocEnum.invalid
              : TextFieldFormBlocEnum.valid,
          refresh: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });
  }
}
