import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/responsive.dart';
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
                  "Quel type de liens voulez-vous créer ?",
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
        SliverGrid.count(
          crossAxisCount: Responsive.isMobile(context) ? 2 : 3,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          childAspectRatio: 1 / 1,
          children: <Widget>[
            Card(
              child: InkWell(
                onTap: () => context.read<LinkEditorBloc>().add(
                      const OnLinkEditorUpdatedEvent(
                        data: {
                          "type_link": typeLinkEnum.short,
                        },
                      ),
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      "Short link",
                    ),
                  ],
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Text("Bottom popin"),
                  ],
                ),
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              TextButton(
                onPressed: () => context.read<LinkEditorBloc>().add(
                      OnPreviewLinkEditorEvent(),
                    ),
                child: const Text("Cancel"),
              ),
            ],
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            semanticIndexOffset: 0,
          ),
        ),
      ],
    );
  }
}
