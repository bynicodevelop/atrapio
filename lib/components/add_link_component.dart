import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/services/add_link/add_link_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLinkComponent extends StatefulWidget {
  const AddLinkComponent({Key? key}) : super(key: key);

  @override
  State<AddLinkComponent> createState() => _AddLinkComponentState();
}

class _AddLinkComponentState extends State<AddLinkComponent> {
  final TextEditingController _srcController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _paramsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return BlocListener<AddLinkBloc, AddLinkState>(
            listener: (context, state) {
              if (state is AddLinkSuccess) {
                _srcController.clear();
                _sourceController.clear();
                _typeController.clear();
                _nameController.clear();
                _paramsController.clear();

                Navigator.pop(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      t(context)!.linkFormCreatorTitle,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _srcController,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        labelText: t(context)!.linkFormCreatorLink,
                        helperText: t(context)!.linkFormCreatorLinkHelper,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _sourceController,
                      decoration: InputDecoration(
                        labelText: t(context)!.linkFormCreatorSource,
                        helperText: t(context)!.linkFormCreatorSourceHelper,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _typeController,
                      decoration: InputDecoration(
                        labelText: t(context)!.linkFormCreatorCampaignType,
                        helperText:
                            t(context)!.linkFormCreatorCampaignTypeHelper,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: t(context)!.linkFormCreatorCampaignName,
                        helperText:
                            t(context)!.linkFormCreatorCampaignNameHelper,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _paramsController,
                      decoration: InputDecoration(
                        labelText: t(context)!.linkFormCreatorParams,
                        helperText: t(context)!.linkFormCreatorParamsHelper,
                      ),
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
                            t(context)!
                                .linkFormCreatorCancelButton
                                .toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AddLinkBloc>().add(
                                  OnCreateLinkEvent(
                                    params: {
                                      "src": _srcController.text,
                                      "source": _sourceController.text,
                                      "type": _typeController.text,
                                      "name": _nameController.text,
                                      "params": _paramsController.text,
                                    },
                                  ),
                                );
                          },
                          child: Text(
                            t(context)!
                                .linkFormCreatorCreateButton
                                .toUpperCase(),
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
      child: const FaIcon(
        FontAwesomeIcons.plus,
        size: 20.0,
      ),
    );
  }
}
