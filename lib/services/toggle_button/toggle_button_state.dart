part of 'toggle_button_bloc.dart';

class ToggleButtonState extends Equatable {
  final bool isOn;

  const ToggleButtonState({
    required this.isOn,
  });

  static const isOff = ToggleButtonState(
    isOn: false,
  );

  ToggleButtonState toggle() => ToggleButtonState(
        isOn: !isOn,
      );

  @override
  List<Object> get props => [
        isOn,
      ];
}
