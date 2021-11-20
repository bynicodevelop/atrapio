import 'package:atrap_io/components/forms/email_field.dart';
import 'package:atrap_io/components/forms/password_field.dart';
import 'package:atrap_io/services/auth_form/auth_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AuthFormComponent extends StatelessWidget {
  final String buttonLabel;

  final Function(Map<String, String>) onPressed;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  const AuthFormComponent({
    Key? key,
    required this.buttonLabel,
    required this.onPressed,
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  }) : super(key: key);

  static form({
    required String buttonLabel,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
    required Function(Map<String, String>) onPressed,
  }) =>
      AuthFormComponent(
        buttonLabel: buttonLabel,
        onPressed: onPressed,
        emailController: emailController,
        passwordController: passwordController,
        emailFocusNode: emailFocusNode,
        passwordFocusNode: passwordFocusNode,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailField(
          emailController: emailController,
          emailFocusNode: emailFocusNode,
        ),
        PasswordField(
          passwordController: passwordController,
          passwordFocusNode: passwordFocusNode,
        ),
        BlocBuilder<AuthFormBloc, AuthFormState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.status.isValidated
                          ? () => onPressed({
                                "email": emailController.text,
                                "password": passwordController.text,
                              })
                          : null,
                      child: Text(
                        buttonLabel.toUpperCase(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
