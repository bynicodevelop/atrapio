import 'package:atrap_io/bootstrap_screen.dart';
import 'package:atrap_io/components/auth_form_component.dart';
import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/screens/register_screen.dart';
import 'package:atrap_io/services/auth_form/auth_form_bloc.dart';
import 'package:atrap_io/services/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        context.read<AuthFormBloc>().add(
              EmailChangedEvent(
                email: emailController.text,
              ),
            );
      }
    });

    emailController.addListener(() {
      context.read<AuthFormBloc>().add(
            EmailChangedEvent(
              email: emailController.text,
            ),
          );
    });

    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        context.read<AuthFormBloc>().add(
              PasswordChangedEvent(
                password: passwordController.text,
              ),
            );
      }
    });

    passwordController.addListener(() {
      context.read<AuthFormBloc>().add(
            PasswordChangedEvent(
              password: passwordController.text,
            ),
          );
    });
  }

  Widget _wrapper({
    required Widget child,
    double padding = 20.0,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: child,
      );

  Widget _loginForm(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 70.0,
          ),
          child: Image.asset(
            "assets/logo_1080_transparent.png",
            height: 100,
          ),
        ),
        Text(
          t(context)!.loginTitle,
          style: Theme.of(context).textTheme.headline5,
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                BootstrapScreen.routeName,
                (route) => false,
              );
            }

            if (state is LoginFailureState) {
              if (state.error == AuthenticationException.badCredentials) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t(context)!.loginErrorBadCredentials),
                  ),
                );
              }
            }
          },
          child: AuthFormComponent.form(
            buttonLabel: t(context)!.connexionButton,
            emailController: emailController,
            passwordController: passwordController,
            emailFocusNode: emailFocusNode,
            passwordFocusNode: passwordFocusNode,
            onPressed: (data) => context.read<LoginBloc>().add(
                  LoginSubmitEvent(
                    email: data["email"]!,
                    password: data["password"]!,
                  ),
                ),
          ),
        ),
        Column(
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                RegisterScreen.routeName,
              ),
              child: Text(
                t(context)!.gotToRegisterLink.toUpperCase(),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = _loginForm(context);

    return Scaffold(
      body: Responsive(
        mobile: _wrapper(
          child: child,
        ),
        tablet: _wrapper(
          child: child,
          padding: (MediaQuery.of(context).size.width - 400) / 2,
        ),
        desktop: _wrapper(
          child: child,
          padding: (MediaQuery.of(context).size.width - 400) / 2,
        ),
      ),
    );
  }
}
