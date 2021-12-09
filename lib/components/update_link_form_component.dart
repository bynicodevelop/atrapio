import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/services/update_link/update_link_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class UpdateLinkFormComponent extends StatefulWidget {
  final LinkModel linkModel;

  const UpdateLinkFormComponent({
    Key? key,
    required this.linkModel,
  }) : super(key: key);

  @override
  _UpdateLinkFormComponentState createState() =>
      _UpdateLinkFormComponentState();
}

class _UpdateLinkFormComponentState extends State<UpdateLinkFormComponent> {
  late final TextEditingController _nameController;

  bool _isDisabled = false;

  @override
  void initState() {
    _nameController = TextEditingController(
      text: widget.linkModel.name.isEmpty
          ? "$kDomain/l/${widget.linkModel.linkId}"
          : widget.linkModel.name,
    );

    super.initState();

    _nameController.addListener(() {
      setState(() => _isDisabled = _nameController.text.isEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateLinkBloc, UpdateLinkState>(
      listener: (context, state) {
        if (state is UpdateLinkSuccessState) {
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.8,
          left: 10.0,
          right: 10.0,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Text(
                t(context)!.updadeLinkTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: t(context)!.updadeLinkNameField,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      t(context)!.updadeLinkCancelButton,
                    ),
                  ),
                  TextButton(
                    onPressed: _isDisabled
                        ? null
                        : () => context.read<UpdateLinkBloc>().add(
                              UpdateLinkModelEvent(linkData: {
                                ...widget.linkModel.toJson(),
                                ...{
                                  'name': _nameController.text,
                                },
                              }),
                            ),
                    child: Text(
                      t(context)!.updadeLinkUpdateButton,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
