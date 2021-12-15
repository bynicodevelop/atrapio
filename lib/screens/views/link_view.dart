import 'package:atrap_io/components/card_list_link_component.dart';
import 'package:atrap_io/components/link_form_component.dart';
import 'package:atrap_io/components/update_link_form_component.dart';
import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/services/delete_link/delete_link_bloc.dart';
import 'package:atrap_io/services/list_links/list_links_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkView extends StatefulWidget {
  const LinkView({Key? key}) : super(key: key);

  @override
  State<LinkView> createState() => _LinkViewState();
}

class _LinkViewState extends State<LinkView> {
  final ScrollController _linkFormSrollController = ScrollController();
  final ScrollController _linkListSrollController = ScrollController();

  CardListLinkComponent _itemCard(
    BuildContext context,
    ListLinksInitialState state,
    int index,
  ) {
    List<Widget> actions = [
      IconButton(
        icon: const FaIcon(
          FontAwesomeIcons.copy,
          size: 18,
        ),
        onPressed: () async {
          await Clipboard.setData(
            ClipboardData(
              text: "$kDomain/l/${state.links[index].linkId}",
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t(context)!.notificationLinkCopied),
            ),
          );
        },
      ),
    ];

    if (!Responsive.isMobile(context)) {
      actions.add(
        Padding(
          padding: const EdgeInsets.only(
            left: 15.0,
          ),
          child: IconButton(
            onPressed: () async => _deleteItem(
              context,
              state,
              index,
            ),
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ),
      );
    }

    return CardListLinkComponent(
      link: state.links[index],
      actions: actions,
    );
  }

  Dismissible _dismissibleItem(
    ListLinksInitialState state,
    int index,
    BuildContext context,
  ) =>
      Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(
          "${state.links[index].linkId}-${DateTime.now().millisecondsSinceEpoch}",
        ),
        onDismissed: (direction) => _deleteItem(
          context,
          state,
          index,
        ),
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
            child: FaIcon(
              FontAwesomeIcons.trash,
              color: Colors.white,
              size: 18.0,
            ),
          ),
        ),
        child: _itemCard(
          context,
          state,
          index,
        ),
      );

  void _deleteItem(
      BuildContext context, ListLinksInitialState state, int index) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(
              seconds: 5,
            ),
            content: Text(t(context)!.notificationLinkDeleted),
            action: SnackBarAction(
              label: t(context)!.notificationCancelLink.toUpperCase(),
              onPressed: () {
                context.read<ListLinksBloc>().add(OnLoadListLinksEvent());
              },
            ),
          ),
        )
        .closed
        .then((value) {
      if (value == SnackBarClosedReason.timeout) {
        context.read<DeleteLinkBloc>().add(
              OnDeleteLinkEvent(
                state.links[index],
              ),
            );
      }
    });
  }

  Row _viewWithRow(BuildContext context, ListLinksInitialState state) {
    return Row(
      children: [
        Container(
          width: 350,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1.0,
                color: Colors.blue,
              ),
            ),
            color: Colors.white,
          ),
          child: ListView(
            controller: _linkFormSrollController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 15.0,
                ),
                child: Text(
                  t(context)!.linkFormCreatorTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              LinkFormComponent(),
            ],
          ),
        ),
        Expanded(
          child: state.links.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t(context)!.noLinkLabel,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _linkListSrollController,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  itemCount: state.links.length,
                  itemBuilder: (context, index) => Responsive.isMobile(context)
                      ? _dismissibleItem(
                          state,
                          index,
                          context,
                        )
                      : _itemCard(
                          context,
                          state,
                          index,
                        ),
                ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListLinksBloc, ListLinksState>(
      bloc: context.read<ListLinksBloc>()..add(OnLoadListLinksEvent()),
      builder: (BuildContext context, state) {
        if (state is ListLinksInitialState) {
          // if (state.links.isEmpty) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           t(context)!.noLinkLabel,
          //         ),
          //       ],
          //     ),
          //   );
          // }

          return Responsive(
            mobile: state.links.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t(context)!.noLinkLabel,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    itemCount: state.links.length,
                    itemBuilder: (context, index) =>
                        Responsive.isMobile(context)
                            ? _dismissibleItem(
                                state,
                                index,
                                context,
                              )
                            : _itemCard(
                                context,
                                state,
                                index,
                              ),
                  ),
            tablet: _viewWithRow(
              context,
              state,
            ),
            desktop: _viewWithRow(
              context,
              state,
            ),
          );
        }

        return Center(
          child: SpinKitThreeBounce(
            size: 15.0,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
