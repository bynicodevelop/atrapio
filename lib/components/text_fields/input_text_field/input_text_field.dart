import 'package:atrap_io/components/text_fields/input_text_field/bloc/input_text_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(bool) onChanged;
  final String labelText;
  final String? helperText;
  final String? errorText;
  final bool required;

  const InputTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.onChanged,
    this.helperText,
    this.errorText,
    this.required = false,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late UniqueKey _key;

  @override
  void initState() {
    super.initState();

    _key = UniqueKey();

    widget.controller.addListener(() {
      context.read<InputTextFieldBloc>().add(
            OnInputTextFieldChangedEvent(
              key: _key,
              value: widget.controller.text,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InputTextFieldBloc, InputTextFieldState>(
      listener: (context, state) {
        if (state is InputTextFieldInitialState) {
          if (state.key == _key) {
            if (widget.required) {
              widget.onChanged(state.isValid == StringTextFieldEnum.invalid);
            } else {
              widget.onChanged(true);
            }
          }
        }
      },
      builder: (context, state) {
        bool showError = false;

        if ((state as InputTextFieldInitialState).key == _key) {
          showError = state.isValid == StringTextFieldEnum.invalid;

          if (state.value.isNotEmpty) {
            widget.controller.text = state.value;

            widget.controller.selection =
                TextSelection.fromPosition(TextPosition(
              offset: widget.controller.text.length,
            ));
          }
        }

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: TextField(
            keyboardType: TextInputType.url,
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.labelText,
              helperText: widget.helperText ?? '',
              errorText: widget.errorText != null && showError
                  ? widget.errorText
                  : null,
            ),
          ),
        );
      },
    );
  }
}
