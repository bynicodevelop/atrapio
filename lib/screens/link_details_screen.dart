import 'package:atrap_io/helpers/clipboard_helper.dart';
import 'package:atrap_io/services/get_link/get_link_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinkDetailsScreen extends StatelessWidget {
  static const routeName = '/link-details';

  const LinkDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return BlocBuilder<GetLinkBloc, GetLinkState>(
      bloc: BlocProvider.of<GetLinkBloc>(context)
        ..add(
          OnGetLinkEvent(
            uid: args['data']!,
          ),
        ),
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text("Link: ${args['data']}"),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.copy,
                size: 18,
              ),
              onPressed: () async => await ClipBoardHelper.copy(
                context,
                args['data'] as String,
              ),
            ),
          ],
        ),
        body: state is GetLinkLoadingState
            ? const Center(
                child: Text("Loading"),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if ((state as GetLinkInitialState).linkModel.metadata !=
                          null &&
                      !state.linkModel.metadata!.isEmpty)
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                              ),
                              child: CachedNetworkImage(
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                ),
                                imageUrl: state.linkModel.metadata!.image,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                state.linkModel.metadata!.title,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  Card(
                    child: ListTile(
                      title: Text(
                        state.linkModel.src,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        state.linkModel.visits.length.toString(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
