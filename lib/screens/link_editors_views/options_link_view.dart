import 'package:atrap_io/components/text_fields/input_text_field/input_text_field.dart';
import 'package:atrap_io/components/text_fields/text_field_form/text_field_form_bloc.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/services/add_link/add_link_bloc.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class OptionsLinkView extends StatefulWidget {
  const OptionsLinkView({Key? key}) : super(key: key);

  @override
  State<OptionsLinkView> createState() => _OptionsLinkViewState();
}

class _OptionsLinkViewState extends State<OptionsLinkView> {
  final TextEditingController _utmSourceController = TextEditingController();
  final TextEditingController _utmMediumController = TextEditingController();
  final TextEditingController _utmCampaignController = TextEditingController();
  final TextEditingController _utmIdController = TextEditingController();
  final TextEditingController _utmTermController = TextEditingController();
  final TextEditingController _utmContentController = TextEditingController();
  final TextEditingController _paramsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<LinkEditorBloc, LinkEditorState>(
        listener: (context, state) {
          if (state is LinkEditorInitialState) {
            context.read<AddLinkBloc>().add(
                  OnCreateLinkEvent(
                    params: state.toJson(),
                  ),
                );
          }
        },
        child: BlocBuilder<TextFieldFormBloc, TextFieldFormState>(
            bloc: context.read<TextFieldFormBloc>()
              ..add(
                const OnTextFieldFormInitializedEvent(
                  data: {
                    "source": false,
                  },
                ),
              ),
            builder: (context, state) {
              return Column(
                children: [
                  InputTextField(
                    controller: _utmSourceController,
                    labelText: t(context)!.linkFormCreatorUtmSource,
                    helperText: t(context)!.linkFormCreatorUtmSourceHelper,
                    onChanged: (isValid) {},
                  ),
                  InputTextField(
                    controller: _utmMediumController,
                    labelText: t(context)!.linkFormCreatorUtmMedium,
                    helperText: t(context)!.linkFormCreatorUtmMediumHelper,
                    onChanged: (isValid) {},
                  ),
                  InputTextField(
                    controller: _utmCampaignController,
                    labelText: t(context)!.linkFormCreatorUtmCampaign,
                    helperText: t(context)!.linkFormCreatorUtmCampaignHelper,
                    onChanged: (isValid) {},
                  ),
                  InputTextField(
                    controller: _utmIdController,
                    labelText: t(context)!.linkFormCreatorUtmId,
                    helperText: t(context)!.linkFormCreatorUtmIdHelper,
                    onChanged: (isValid) {},
                  ),
                  InputTextField(
                    controller: _utmTermController,
                    labelText: t(context)!.linkFormCreatorUtmTerm,
                    helperText: t(context)!.linkFormCreatorUtmTermHelper,
                    onChanged: (isValid) {},
                  ),
                  InputTextField(
                    controller: _utmContentController,
                    labelText: t(context)!.linkFormCreatorUtmContent,
                    helperText: t(context)!.linkFormCreatorUtmContentHelper,
                    onChanged: (isValid) {},
                  ),
                  InputTextField(
                    controller: _paramsController,
                    labelText: t(context)!.linkFormCreatorParams,
                    helperText: t(context)!.linkFormCreatorParamsHelper,
                    onChanged: (isValid) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: (context.watch<TextFieldFormBloc>().state
                                        as TextFieldFormInitialState)
                                    .status ==
                                TextFieldFormBlocEnum.invalid
                            ? null
                            : () {
                                context.read<LinkEditorBloc>().add(
                                      OnLinkEditorUpdatedEvent(
                                        data: {
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
                        child: const Text("Continuer"),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
