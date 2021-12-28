import 'package:atrap_io/components/text_fields/text_field_form/text_field_form_bloc.dart';
import 'package:atrap_io/components/text_fields/url_text_field/url_text_field.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class StartLinkEditorView extends StatefulWidget {
  const StartLinkEditorView({Key? key}) : super(key: key);

  @override
  State<StartLinkEditorView> createState() => _StartLinkEditorViewState();
}

class _StartLinkEditorViewState extends State<StartLinkEditorView> {
  final TextEditingController _srcController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldFormBloc, TextFieldFormState>(
      bloc: context.read<TextFieldFormBloc>()
        ..add(
          const OnTextFieldFormInitializedEvent(
            data: {
              "src": TextFieldFormBlocEnum.invalid,
            },
          ),
        ),
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UrlTextField(
              required: true,
              controller: _srcController,
              labelText: "Entrer une url",
              errorText: "Vous devez saisir une url valide",
              helperText:
                  "Si vous souhaitez ajouter des options de tracking (UTM) à votre lien, vous pourrez le faire dans les étapes suivantes.",
              onChanged: (isValid) => context.read<TextFieldFormBloc>().add(
                    OnTextFieldFormEvent(
                      data: {
                        "src": isValid,
                      },
                    ),
                  ),
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
                          if (_srcController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Vous devez saisir une url valide'),
                              ),
                            );

                            return;
                          }

                          context.read<LinkEditorBloc>().add(
                                OnLinkEditorUpdatedEvent(
                                  data: {
                                    'src': _srcController.text,
                                  },
                                ),
                              );
                        },
                  child: const Text("Continuer"),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
