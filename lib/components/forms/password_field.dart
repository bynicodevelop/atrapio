import 'package:atrap_io/components/toggle_button.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/services/auth_form/auth_form_bloc.dart';
import 'package:atrap_io/services/toggle_button/toggle_button_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.passwordFocusNode,
    required this.passwordController,
  }) : super(key: key);

  final FocusNode passwordFocusNode;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleButtonBloc(),
      child: BlocBuilder<AuthFormBloc, AuthFormState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  obscureText: !context.watch<ToggleButtonBloc>().state.isOn,
                  decoration: InputDecoration(
                    labelText: t(context)!.passwordField,
                    errorText: passwordController.text.isNotEmpty &&
                            !state.password.valid
                        ? 'Please ensure the password entered is valid'
                        : null,
                    suffixIcon: const ToggleButton(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
