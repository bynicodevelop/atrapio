import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TypeLinkView extends StatelessWidget {
  const TypeLinkView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Quel type de liens voulez-vous créer ?"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: InkWell(
                onTap: () => context.read<LinkEditorBloc>().add(
                      const OnLinkEditorUpdatedEvent(
                        data: {
                          "type_link": typeLinkEnum.short,
                        },
                      ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Icon(
                          FontAwesomeIcons.link,
                          size: 20,
                        ),
                      ),
                      Text("Short link"),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () => context.read<LinkEditorBloc>().add(
                      const OnLinkEditorUpdatedEvent(
                        data: {
                          "type_link": typeLinkEnum.optinLink,
                        },
                      ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.funnelDollar,
                          size: 20,
                        ),
                      ),
                      Text("@Trap link")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () => context.read<LinkEditorBloc>().add(
                OnPreviewLinkEditorEvent(),
              ),
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
