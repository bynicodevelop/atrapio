import 'package:atrap_io/components/add_link_component.dart';
import 'package:atrap_io/responsive.dart';
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
              )
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
          // bottomNavigationBar: BottomNavigationBar(
          //   items: <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: const Padding(
          //         padding: EdgeInsets.all(4.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.home,
          //           size: 20.0,
          //         ),
          //       ),
          //       label: t(context)!.bottomNavigationHome,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: const Padding(
          //         padding: EdgeInsets.all(4.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.link,
          //           size: 20.0,
          //         ),
          //       ),
          //       label: t(context)!.bottomNavigationLinks,
          //     ),
          //   ],
          //   onTap: (index) => context.read<MainNavigationBloc>().add(
          //         OnNavigateEvent(index),
          //       ),
          //   currentIndex: (context.watch<MainNavigationBloc>().state
          //           as MainNavigationInitialState)
          //       .currentIndex,
          // ),
        ),
      ),
    );
  }
}
