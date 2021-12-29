import 'package:atrap_io/models/optin_model.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

const List<OptinModel> optins = [
  OptinModel(
    name: "Popin Redirection",
    description:
        "Affiche une popin pour attirer l'attention de l'utilisateur et le rediriger vers une page",
  ),
];

class OptinLinkView extends StatelessWidget {
  const OptinLinkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                ),
                child: Text(
                  "Quel type optin voulez-vous configurer ?",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              )
            ],
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            semanticIndexOffset: 0,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            optins
                .map((optin) => Card(
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
                    ))
                .toList(),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            semanticIndexOffset: 0,
          ),
        ),
      ],
    );

    // ListView.builder(
    //   padding: const EdgeInsets.only(
    //     top: 16,
    //   ),
    //   itemCount: optins.length,
    //   itemBuilder: (context, index) {
    //     final OptinModel optin = optins[index];

    //     return Card(
    //       child: ListTile(
    //         title: Text(optin.name),
    //         subtitle: Text(optin.description),
    //         onTap: () => context.read<LinkEditorBloc>().add(
    //               OnLinkEditorUpdatedEvent(
    //                 data: {
    //                   "optin_model": optin,
    //                 },
    //               ),
    //             ),
    //       ),
    //     );
    //   },
    // );
  }
}
