import 'package:atrap_io/screens/link_editor_stepper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddLinkComponent extends StatefulWidget {
  const AddLinkComponent({Key? key}) : super(key: key);

  @override
  State<AddLinkComponent> createState() => _AddLinkComponentState();
}

class _AddLinkComponentState extends State<AddLinkComponent> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(
        context,
        LinkEditorStepper.routeName,
      ),
      child: const FaIcon(
        FontAwesomeIcons.plus,
        size: 20.0,
      ),
    );
  }
}
