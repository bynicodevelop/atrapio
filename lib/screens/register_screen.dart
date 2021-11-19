import 'package:atrap_io/bootstrap_screen.dart';
import 'package:atrap_io/components/auth_form_component.dart';
import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/screens/login_screen.dart';
import 'package:atrap_io/services/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  const RegisterScreen({Key? key}) : super(key: key);

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

  Widget _registerForm(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            t(context)!.registerTitle,
            style: Theme.of(context).textTheme.headline5,
          ),
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccessState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  BootstrapScreen.routeName,
                  (route) => false,
                );
              }

              if (state is RegisterFailureState) {
                if (state.error == AuthenticationException.emailAlreadyExists) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        t(context)!.registerErrorEmailAlreadyExists,
                      ),
                    ),
                  );
                }
              }
            },
            child: AuthFormComponent.form(
              buttonLabel: t(context)!.registerButton,
              onPressed: (data) => context.read<RegisterBloc>().add(
                    RegisterSubmitEvent(
                      email: data['email'],
                      password: data['password'],
                    ),
                  ),
            ),
          ),
          Column(
            children: [
              TextButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  LoginScreen.routeName,
                ),
                child: Text(
                  t(context)!.gotToLoginLink.toUpperCase(),
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
          child: _registerForm(context),
        ),
        tablet: _wrapper(
          child: _registerForm(context),
          padding: (MediaQuery.of(context).size.width - 400) / 2,
        ),
        desktop: _wrapper(
          child: _registerForm(context),
          padding: (MediaQuery.of(context).size.width - 400) / 2,
        ),
      ),
    );
  }
}
