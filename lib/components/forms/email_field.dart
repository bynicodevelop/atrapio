import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/services/auth_form/auth_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.emailFocusNode,
    required this.emailController,
  }) : super(key: key);

  final FocusNode emailFocusNode;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthFormBloc, AuthFormState>(
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                controller: emailController,
                decoration: InputDecoration(
                  labelText: t(context)!.emailField,
                  errorText:
                      emailController.text.isNotEmpty && !state.email.valid
                          ? 'Please ensure the email entered is valid'
                          : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
