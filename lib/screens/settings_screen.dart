import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/screens/get_tracker_screen.dart';
import 'package:atrap_io/services/logout/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  Widget _view(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                onTap: () => Navigator.pushNamed(
                  context,
                  GetTrackerScreen.routeName,
                ),
                title: Text(
                  t(context)!.settingsItemGetTracker,
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.chevronRight,
                  size: 20.0,
                ),
              ),
            ),
            BlocBuilder<LogoutBloc, LogoutState>(
              builder: (context, state) => Card(
                child: ListTile(
                  onTap: () => context.read<LogoutBloc>().add(
                        LogoutSubmitEvent(),
                      ),
                  title: Text(
                    t(context)!.settingsItemLogout,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.red,
                        ),
                  ),
                  trailing: const FaIcon(
                    FontAwesomeIcons.signOutAlt,
                    size: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(context)!.settingsTitle,
        ),
      ),
      body: Responsive(
        mobile: _view(context),
        tablet: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 400) / 2,
          ),
          child: _view(context),
        ),
        desktop: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 400) / 2,
          ),
          child: _view(context),
        ),
      ),
    );
  }
}
