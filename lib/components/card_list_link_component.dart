import 'package:atrap_io/components/update_link_form_component.dart';
import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/screens/link_details_screen.dart';
import 'package:flutter/material.dart';

class CardListLinkComponent extends StatelessWidget {
  final List<Widget> actions;
  final LinkModel link;

  const CardListLinkComponent({
    Key? key,
    required this.link,
    required this.actions,
  }) : super(key: key);

  void _modal(
    BuildContext context,
    LinkModel linkModel,
  ) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => UpdateLinkFormComponent(
          linkModel: linkModel,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        dense: true,
        onTap: () => Navigator.pushNamed(
          context,
          "${LinKDetailsScreen.routeName}/${link.linkId}",
        ),
        onLongPress: () => _modal(
          context,
          link,
        ),
        title: Text(
          link.name.isNotEmpty ? link.name : "$kDomain/l/${link.linkId}",
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8.0,
              ),
              child: Text(
                link.src,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "Clicks : ${link.clicks}",
            ),
          ],
        ),
        trailing: SizedBox(
          width: actions.length * 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: actions,
          ),
        ),
      ),
    );
  }
}
