import 'package:atrap_io/components/text_fields/url_text_field/bloc/url_text_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrlTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? helperText;
  final String errorText;
  final Function(bool) onChanged;
  final bool required;

  const UrlTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.errorText,
    required this.onChanged,
    this.helperText,
    this.required = false,
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
          if (widget.required) {
            widget.onChanged(state.isValid == UrlTextFieldEnum.invalid);
          } else {
            widget.onChanged(true);
          }
        }
      },
      builder: (context, state) {
        bool showError = false;

        if (widget.required) {
          if (state is UrlTextFieldInitialState) {
            if (state.url.isNotEmpty) {
              showError = state.isValid == UrlTextFieldEnum.invalid;

              // widget.controller.text = state.url;

              // widget.controller.selection =
              //     TextSelection.fromPosition(TextPosition(
              //   offset: widget.controller.text.length,
              // ));
            } else {
              showError = true;
            }
          }
        } else {
          if (state is UrlTextFieldInitialState && state.url.isNotEmpty) {
            showError = state.isValid == UrlTextFieldEnum.invalid;
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
              helperText: widget.helperText,
              helperMaxLines: 2,
              hintText: widget.labelText,
              errorText: !showError ? null : widget.errorText,
            ),
          ),
        );
      },
    );
  }
}
