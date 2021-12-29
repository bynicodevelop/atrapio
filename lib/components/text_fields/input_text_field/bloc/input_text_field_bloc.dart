import 'package:atrap_io/validators/string_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'input_text_field_event.dart';
part 'input_text_field_state.dart';

class InputTextFieldBloc
    extends Bloc<InputTextFieldEvent, InputTextFieldState> {
  InputTextFieldBloc()
      : super(
          InputTextFieldInitialState(
            key: UniqueKey(),
          ),
        ) {
    on<OnInputTextFieldChangedEvent>((event, emit) {
      final StringValidator string = StringValidator.dirty(event.value);

      emit(InputTextFieldInitialState(
        key: event.key,
        value: event.value,
        isValid: string.valid
            ? StringTextFieldEnum.valid
            : StringTextFieldEnum.invalid,
      ));
    });
  }
}
