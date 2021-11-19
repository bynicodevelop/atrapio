import 'package:atrap_io/services/toggle_button/toggle_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleButtonBloc, ToggleButtonState>(
      builder: (context, state) {
        return IconButton(
          icon: FaIcon(
            state.isOn ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            size: 20,
          ),
          onPressed: () {
            context.read<ToggleButtonBloc>().add(ToggleButtonPressedEvent());
          },
        );
      },
    );
  }
}
