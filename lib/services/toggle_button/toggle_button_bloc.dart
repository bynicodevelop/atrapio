import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_button_event.dart';
part 'toggle_button_state.dart';

class ToggleButtonBloc extends Bloc<ToggleButtonEvent, ToggleButtonState> {
  ToggleButtonBloc() : super(ToggleButtonState.isOff) {
    on<ToggleButtonPressedEvent>((event, emit) {
      emit(state.toggle());
    });
  }
}
