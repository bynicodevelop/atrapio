import 'package:atrap_io/models/optin_model.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

const List<OptinModel> optins = [
  OptinModel(
    name: "Optin Redirection",
    description: "Permet de rediriger un utilisateur est un lien spécifique",
  ),
];

class OptinLinkView extends StatelessWidget {
  const OptinLinkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: optins.length,
        itemBuilder: (context, index) {
          final OptinModel optin = optins[index];

          return Card(
            child: ListTile(
              title: Text(optin.name),
              subtitle: Text(optin.description),
              onTap: () => context.read<LinkEditorBloc>().add(
                    OnLinkEditorUpdatedEvent(
                      data: {
                        "optin_model": optin,
                      },
                    ),
                  ),
            ),
          );
        });
  }
}
