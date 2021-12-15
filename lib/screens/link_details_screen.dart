import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/services/link_details/link_details_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LinKDetailsScreen extends StatelessWidget {
  static const routeName = '/link-details';

  const LinKDetailsScreen({Key? key}) : super(key: key);

  Widget _view(BuildContext context, Map<String, dynamic> args) =>
      BlocBuilder<LinkDetailsBloc, LinkDetailsState>(
          bloc: context.read<LinkDetailsBloc>()
            ..add(
              OnLinkDetailsEvent(
                linkId: args['data']!,
              ),
            ),
          builder: (context, state) {
            if (state is LinkDetailsLoadingState ||
                state is LinkDetailsInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LinkDetailsErrorState) {
              return const Center(
                child: Text('Error'),
              );
            }

            final LinkModel linkModel =
                (state as LinkDetailsLoadedState).linkModel;

            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.black12,
                                    child: const Icon(
                                      Icons.image_not_supported_outlined,
                                    ),
                                  ),
                                  imageUrl: linkModel.metadata["image"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text: "$kDomain/l/${linkModel.linkId}",
                                    ),
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          t(context)!.notificationLinkCopied),
                                    ),
                                  );
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.copy,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            title: Text(
                              linkModel.metadata["name"],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio:
                        !Responsive.isMobile(context) ? 19 / 9 : 16 / 13,
                  ),
                  delegate: SliverChildListDelegate.fixed([
                    Padding(
                      padding: EdgeInsets.only(
                        left: !Responsive.isMobile(context) ? 0.0 : 5.0,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                t(context)!.linkDetailsInHour.toUpperCase(),
                                style: Theme.of(context).textTheme.overline,
                              ),
                              Text(
                                linkModel.stats["clicks_per_hours"].toString(),
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: !Responsive.isMobile(context) ? 0.0 : 5.0,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                t(context)!.linkDetailsInDay.toUpperCase(),
                                style: Theme.of(context).textTheme.overline,
                              ),
                              Text(
                                linkModel.stats["clicks_per_days"].toString(),
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            );
          });

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text(t(context)!.linkDetailsTitle),
      ),
      body: Responsive(
        mobile: _view(context, args),
        tablet: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 600) / 2,
          ),
          child: _view(context, args),
        ),
        desktop: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (MediaQuery.of(context).size.width - 600) / 2,
          ),
          child: _view(context, args),
        ),
      ),
    );
  }
}
