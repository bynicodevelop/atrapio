import 'package:atrap_io/components/forms/email_field.dart';
import 'package:atrap_io/components/forms/password_field.dart';
import 'package:atrap_io/services/auth_form/auth_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AuthFormComponent extends StatefulWidget {
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
    required buttonLabel,
    required onPressed,
  }) =>
      AuthFormComponent(
        buttonLabel: buttonLabel,
        onPressed: onPressed,
        emailController: TextEditingController(
          text: "",
        ),
        passwordController: TextEditingController(
          text: "",
        ),
        emailFocusNode: FocusNode(),
        passwordFocusNode: FocusNode(),
      );

  @override
  State<AuthFormComponent> createState() => _AuthFormComponentState();
}

class _AuthFormComponentState extends State<AuthFormComponent> {
  @override
  void initState() {
    super.initState();

    widget.emailFocusNode.addListener(() {
      if (!widget.emailFocusNode.hasFocus) {
        context.read<AuthFormBloc>().add(
              EmailChangedEvent(
                email: widget.emailController.text,
              ),
            );
      }
    });

    widget.emailController.addListener(() {
      context.read<AuthFormBloc>().add(
            EmailChangedEvent(
              email: widget.emailController.text,
            ),
          );
    });

    widget.passwordFocusNode.addListener(() {
      if (!widget.passwordFocusNode.hasFocus) {
        context.read<AuthFormBloc>().add(
              PasswordChangedEvent(
                password: widget.passwordController.text,
              ),
            );
      }
    });

    widget.passwordController.addListener(() {
      context.read<AuthFormBloc>().add(
            PasswordChangedEvent(
              password: widget.passwordController.text,
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailField(
          emailController: widget.emailController,
          emailFocusNode: widget.emailFocusNode,
        ),
        PasswordField(
          passwordController: widget.passwordController,
          passwordFocusNode: widget.passwordFocusNode,
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
                          ? () => widget.onPressed({
                                "email": widget.emailController.text,
                                "password": widget.passwordController.text,
                              })
                          : null,
                      child: Text(
                        widget.buttonLabel.toUpperCase(),
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
