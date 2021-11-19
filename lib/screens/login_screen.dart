import 'package:atrap_io/bootstrap_screen.dart';
import 'package:atrap_io/components/auth_form_component.dart';
import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/screens/register_screen.dart';
import 'package:atrap_io/services/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

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

  Widget _loginForm(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              onPressed: (data) => context.read<LoginBloc>().add(
                    LoginSubmitEvent(
                      email: data["email"],
                      password: data["password"],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: _wrapper(
          child: _loginForm(context),
        ),
        tablet: _wrapper(
          child: _loginForm(context),
          padding: (MediaQuery.of(context).size.width - 400) / 2,
        ),
        desktop: _wrapper(
          child: _loginForm(context),
          padding: (MediaQuery.of(context).size.width - 400) / 2,
        ),
      ),
    );
  }
}
