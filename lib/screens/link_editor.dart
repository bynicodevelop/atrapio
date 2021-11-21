import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/services/add_link/add_link_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkEditor extends StatefulWidget {
  const LinkEditor({Key? key}) : super(key: key);

  @override
  State<LinkEditor> createState() => _LinkEditorState();
}

class _LinkEditorState extends State<LinkEditor> {
  final TextEditingController _srcController = TextEditingController();
  final TextEditingController _utmSourceController = TextEditingController();
  final TextEditingController _utmMediumController = TextEditingController();
  final TextEditingController _utmCampaignController = TextEditingController();
  final TextEditingController _utmIdController = TextEditingController();
  final TextEditingController _utmTermController = TextEditingController();
  final TextEditingController _utmContentController = TextEditingController();
  final TextEditingController _paramsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t(context)!.linkFormCreatorTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocListener<AddLinkBloc, AddLinkState>(
          listener: (context, state) {
            if (state is AddLinkSuccess) {
              _srcController.clear();
              _utmSourceController.clear();
              _utmMediumController.clear();
              _utmCampaignController.clear();
              _utmIdController.clear();
              _utmTermController.clear();
              _utmContentController.clear();
              _paramsController.clear();

              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _srcController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorLink,
                      helperText: t(context)!.linkFormCreatorLinkHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _utmSourceController,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorUtmSource,
                      helperText: t(context)!.linkFormCreatorUtmSourceHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _utmMediumController,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorUtmMedium,
                      helperText: t(context)!.linkFormCreatorUtmMediumHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _utmCampaignController,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorUtmCampaign,
                      helperText: t(context)!.linkFormCreatorUtmCampaignHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _utmIdController,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorUtmId,
                      helperText: t(context)!.linkFormCreatorUtmIdHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _utmTermController,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorUtmTerm,
                      helperText: t(context)!.linkFormCreatorUtmTermHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.next,
                    controller: _utmContentController,
                    decoration: InputDecoration(
                      labelText: t(context)!.linkFormCreatorUtmContent,
                      helperText: t(context)!.linkFormCreatorUtmContentHelper,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.done,
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
                          t(context)!.linkFormCreatorCancelButton.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: context.watch<AddLinkBloc>().state
                                is AddLinkLoading
                            ? null
                            : () {
                                if (_srcController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t(context)!
                                            .linkFormCreatorErrorMessageEmptySrc,
                                      ),
                                    ),
                                  );

                                  return;
                                }

                                context.read<AddLinkBloc>().add(
                                      OnCreateLinkEvent(
                                        params: {
                                          "src": _srcController.text,
                                          "utm_source":
                                              _utmSourceController.text,
                                          "utm_medium":
                                              _utmMediumController.text,
                                          "utm_campaign":
                                              _utmCampaignController.text,
                                          "utm_id": _utmIdController.text,
                                          "utm_term": _utmTermController.text,
                                          "utm_content":
                                              _utmContentController.text,
                                          "params": _paramsController.text,
                                        },
                                      ),
                                    );
                              },
                        child: Text(
                          t(context)!.linkFormCreatorCreateButton.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: context.watch<AddLinkBloc>().state
                                            is AddLinkLoading
                                        ? Colors.grey
                                        : Theme.of(context).primaryColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
