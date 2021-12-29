import 'package:atrap_io/components/image_picker_component.dart';
import 'package:atrap_io/components/text_fields/input_text_field/input_text_field.dart';
import 'package:atrap_io/components/text_fields/text_field_form/text_field_form_bloc.dart';
import 'package:atrap_io/models/optin_param_model.dart';
import 'package:atrap_io/services/image_picker/image_picker_bloc.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomizeOptinLinkView extends StatefulWidget {
  const CustomizeOptinLinkView({Key? key}) : super(key: key);

  @override
  State<CustomizeOptinLinkView> createState() => _CustomizeOptinLinkViewState();
}

class _CustomizeOptinLinkViewState extends State<CustomizeOptinLinkView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _labelButtonController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldFormBloc, TextFieldFormState>(
      bloc: context.read<TextFieldFormBloc>()
        ..add(
          const OnTextFieldFormInitializedEvent(
            data: {
              "name": TextFieldFormBlocEnum.invalid,
              "content": TextFieldFormBlocEnum.invalid,
              "labelButton": TextFieldFormBlocEnum.invalid,
              "image": TextFieldFormBlocEnum.invalid,
            },
          ),
        ),
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocConsumer<ImagePickerBloc, ImagePickerState>(
              listener: (context, state) {
                if (state is ImagePickerInitialState) {
                  if (state.image.isNotEmpty) {
                    _imageController.text = state.image;

                    context.read<TextFieldFormBloc>().add(
                          const OnTextFieldFormEvent(
                            data: {
                              'image': false,
                            },
                          ),
                        );
                  }
                }
              },
              builder: (context, state) {
                return const ImagePickerComponent();
              },
            ),
            InputTextField(
              required: true,
              controller: _nameController,
              labelText: "Nom de votre marque",
              errorText: "Le nom de votre marque est requis",
              onChanged: (isValid) => context.read<TextFieldFormBloc>().add(
                    OnTextFieldFormEvent(
                      data: {
                        'name': isValid,
                      },
                    ),
                  ),
            ),
            InputTextField(
              required: true,
              controller: _contentController,
              labelText: "Contenu d'appel à l'action",
              errorText: "Le contenu est requis",
              onChanged: (isValid) => context.read<TextFieldFormBloc>().add(
                    OnTextFieldFormEvent(
                      data: {
                        'content': isValid,
                      },
                    ),
                  ),
            ),
            InputTextField(
              required: true,
              controller: _labelButtonController,
              labelText: "Nom du bouton",
              errorText: "Le nom du bouton est requis",
              onChanged: (isValid) => context.read<TextFieldFormBloc>().add(
                    OnTextFieldFormEvent(
                      data: {
                        'labelButton': isValid,
                      },
                    ),
                  ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: TextButton(
                    onPressed: () => context.read<LinkEditorBloc>().add(
                          OnPreviewLinkEditorEvent(),
                        ),
                    child: const Text("Cancel"),
                  ),
                ),
                ElevatedButton(
                  onPressed: (context.watch<TextFieldFormBloc>().state
                                  as TextFieldFormInitialState)
                              .status ==
                          TextFieldFormBlocEnum.invalid
                      ? null
                      : () {
                          context.read<LinkEditorBloc>().add(
                                OnLinkEditorUpdatedEvent(
                                  data: {
                                    "optin_param_model":
                                        OptinParamModel.fromJson({
                                      "name": _nameController.text,
                                      "content": _contentController.text,
                                      "labelButton":
                                          _labelButtonController.text,
                                      "image": _imageController.text,
                                    }),
                                  },
                                ),
                              );
                        },
                  child: const Text("Continuer"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
