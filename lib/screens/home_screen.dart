import 'package:atrap_io/components/add_link_component.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/screens/link_editor_stepper.dart';
import 'package:atrap_io/screens/settings_screen.dart';
import 'package:atrap_io/screens/views/link_view.dart';
import 'package:atrap_io/services/main_navigation/main_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainNavigationBloc>(
      create: (context) => MainNavigationBloc(),
      child: BlocConsumer<MainNavigationBloc, MainNavigationState>(
        listener: (context, state) => _pageController.jumpToPage(
          (state as MainNavigationInitialState).currentIndex,
        ),
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("@trap.io"),
            actions: [
              if (!Responsive.isMobile(context))
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      LinkEditorStepper.routeName,
                    ),
                    child: const Text(
                      "Créer un lien",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                ),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    SettingsScreen.routeName,
                  ),
                  icon: const FaIcon(
                    FontAwesomeIcons.cogs,
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<MainNavigationBloc>().add(
                    OnNavigateEvent(index),
                  );
            },
            children: const <Widget>[
              // HomeView(),
              LinkView(),
            ],
          ),
          floatingActionButton:
              Responsive.isMobile(context) ? const AddLinkComponent() : null,
        ),
      ),
    );
  }
}
