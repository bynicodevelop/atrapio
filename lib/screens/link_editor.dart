import 'package:atrap_io/components/link_form_component.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:flutter/material.dart';

class LinkEditor extends StatefulWidget {
  const LinkEditor({Key? key}) : super(key: key);

  @override
  State<LinkEditor> createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(context)!.linkFormCreatorTitle,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: LinkFormComponent(),
        ),
      ),
    );
  }
}
