import 'package:atrap_io/screens/home_screen.dart';
import 'package:atrap_io/screens/login_screen.dart';
import 'package:atrap_io/screens/splash_screen.dart';
import 'package:atrap_io/services/app/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BootstrapScreen extends StatelessWidget {
  static const routeName = '/';

  const BootstrapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, AppState state) {
        if (state.status == AppStatus.unauthenticated) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
      },
      builder: (context, AppState state) {
        if (state.status == AppStatus.authenticated) {
          return const HomeScreen();
        }

        return const SplashScreen();
      },
    );
  }
}
