import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/services/logout/logout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(context)!.settingsTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            BlocBuilder<LogoutBloc, LogoutState>(
              builder: (context, state) => Card(
                child: ListTile(
                  onTap: () => context.read<LogoutBloc>().add(
                        LogoutSubmitEvent(),
                      ),
                  title: Text(
                    t(context)!.settingsItemTitle,
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
      ),
    );
  }
}
