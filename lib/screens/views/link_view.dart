import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/helpers/clipboard_helper.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/screens/link_details_screen.dart';
import 'package:atrap_io/services/delete_link/delete_link_bloc.dart';
import 'package:atrap_io/services/list_links/list_links_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkView extends StatelessWidget {
  const LinkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListLinksBloc, ListLinksState>(
      builder: (BuildContext context, state) {
        if (state is ListLinksInitialState) {
          if (state.links.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t(context)!.noLinkLabel,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.links.length,
            itemBuilder: (context, index) => Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(
                "${state.links[index].linkId}-${DateTime.now().millisecondsSinceEpoch}",
              ),
              onDismissed: (direction) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      SnackBar(
                        duration: const Duration(
                          seconds: 5,
                        ),
                        content: Text(t(context)!.notificationLinkDeleted),
                        action: SnackBarAction(
                          label:
                              t(context)!.notificationCancelLink.toUpperCase(),
                          onPressed: () {
                            context
                                .read<ListLinksBloc>()
                                .add(OnLoadListLinksEvent());
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
              },
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
              child: Card(
                child: ListTile(
                  onTap: () => Navigator.pushNamed(
                    context,
                    "${LinkDetailsScreen.routeName}/${state.links[index].uid}",
                  ),
                  title: Text("$kDomain/l/${state.links[index].linkId}"),
                  subtitle: Text(
                    state.links[index].src,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.copy,
                      size: 18,
                    ),
                    onPressed: () async => await ClipBoardHelper.copy(
                      context,
                      state.links[index].linkId,
                    ),
                  ),
                ),
              ),
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
