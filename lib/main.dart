import 'dart:io';

import 'package:atrap_io/bootstrap_screen.dart';
import 'package:atrap_io/firebase_options.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:atrap_io/repositories/tracker_repository.dart';
import 'package:atrap_io/screens/get_tracker_screen.dart';
import 'package:atrap_io/screens/link_details_screen.dart';
import 'package:atrap_io/screens/login_screen.dart';
import 'package:atrap_io/screens/register_screen.dart';
import 'package:atrap_io/screens/settings_screen.dart';
import 'package:atrap_io/screens/statistics_screen.dart';
import 'package:atrap_io/services/add_link/add_link_bloc.dart';
import 'package:atrap_io/services/app/app_bloc.dart';
import 'package:atrap_io/services/auth_form/auth_form_bloc.dart';
import 'package:atrap_io/services/delete_link/delete_link_bloc.dart';
import 'package:atrap_io/services/generate_tracker/generate_tracker_bloc.dart';
import 'package:atrap_io/services/link_details/link_details_bloc.dart';
import 'package:atrap_io/services/list_links/list_links_bloc.dart';
import 'package:atrap_io/services/login/login_bloc.dart';
import 'package:atrap_io/services/logout/logout_bloc.dart';
import 'package:atrap_io/services/register/register_bloc.dart';
import 'package:atrap_io/services/update_link/update_link_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

final Map<String, Widget> routes = {
  BootstrapScreen.routeName: const BootstrapScreen(),
  LoginScreen.routeName: const LoginScreen(),
  RegisterScreen.routeName: const RegisterScreen(),
  SettingsScreen.routeName: const SettingsScreen(),
  StatisticsScreen.routeName: const StatisticsScreen(),
  GetTrackerScreen.routeName: const GetTrackerScreen(),
  LinKDetailsScreen.routeName: const LinKDetailsScreen(),
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    String host = "localhost";

    if (!kIsWeb) {
      host = Platform.isAndroid ? "10.0.2.2" : host;
    }

    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    FirebaseFunctions.instance.useFunctionsEmulator(
      host,
      5001,
    );
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository =
        AuthenticationRepository(
      firebaseAuth: FirebaseAuth.instance,
    );

    LinkRepository linkRepository = LinkRepository(
      firestore: FirebaseFirestore.instance,
      functions: FirebaseFunctions.instance,
    );

    TrackerRepository trackerRepository = TrackerRepository(
      firestore: FirebaseFirestore.instance,
      functions: FirebaseFunctions.instance,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          lazy: false,
          create: (context) => AppBloc(
            authenticationRepository,
          ),
        ),
        BlocProvider<AuthFormBloc>(
          create: (context) => AuthFormBloc(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => AddLinkBloc(
            linkRepository: linkRepository,
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => ListLinksBloc(
            linkRepository: linkRepository,
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => LinkDetailsBloc(
            linkRepository: linkRepository,
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => DeleteLinkBloc(
            linkRepository,
          ),
        ),
        BlocProvider(
          create: (context) => UpdateLinkBloc(
            linkRepository: linkRepository,
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider(
          create: (context) => GenerateTrackerBloc(
            trackerRepository: trackerRepository,
            authenticationRepository: authenticationRepository,
          ),
        )
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '@Trap.io',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('fr', ''),
      ],
      initialRoute: BootstrapScreen.routeName,
      onGenerateRoute: (settings) {
        String routeName = settings.name!;

        if (settings.name!.contains(LinKDetailsScreen.routeName)) {
          routeName = LinKDetailsScreen.routeName;

          settings = RouteSettings(
            arguments: {
              "data": settings.name!.split("/").last,
            },
            name: routeName,
          );
        }

        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              routes[settings.name]!,
        );
      },
    );
  }
}
