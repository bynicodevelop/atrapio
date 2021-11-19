part of 'toggle_button_bloc.dart';

abstract class ToggleButtonEvent extends Equatable {
  const ToggleButtonEvent();

  @override
  List<Object> get props => [];
}

class ToggleButtonPressedEvent extends ToggleButtonEvent {}
