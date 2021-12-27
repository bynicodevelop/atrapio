import 'package:atrap_io/components/text_fields/url_text_field/bloc/url_text_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? helperText;
  final String errorText;
  final Function(bool) onChanged;

  const UrlTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
    this.helperText,
  }) : super(key: key);

  @override
  State<UrlTextField> createState() => _UrlTextFieldState();
}

class _UrlTextFieldState extends State<UrlTextField> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      context.read<UrlTextFieldBloc>().add(
            OnUrlTextFieldChangedEvent(
              url: widget.controller.text,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UrlTextFieldBloc, UrlTextFieldState>(
      listener: (context, state) {
        if (state is UrlTextFieldInitialState) {
          widget.onChanged(state.isValid == UrlTextFieldEnum.invalid);
        }
      },
      builder: (context, state) {
        if (state is UrlTextFieldInitialState && state.url.isNotEmpty) {
          widget.controller.text = state.url;

          widget.controller.selection = TextSelection.fromPosition(TextPosition(
            offset: widget.controller.text.length,
          ));
        }

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 20.0,
          ),
          child: TextField(
            keyboardType: TextInputType.url,
            controller: widget.controller,
            decoration: InputDecoration(
              helperText: widget.helperText,
              hintText: widget.labelText,
              errorText: (state as UrlTextFieldInitialState).isValid !=
                      UrlTextFieldEnum.invalid
                  ? null
                  : widget.errorText,
            ),
          ),
        );
      },
    );
  }
}
