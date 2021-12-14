import 'package:atrap_io/services/generate_tracker/generate_tracker_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class GenerateTrackingIdForm extends StatefulWidget {
  const GenerateTrackingIdForm({Key? key}) : super(key: key);

  @override
  _GenerateTrackingIdFormState createState() => _GenerateTrackingIdFormState();
}

class _GenerateTrackingIdFormState extends State<GenerateTrackingIdForm> {
  final TextEditingController _urlController = TextEditingController();

  bool _validForm = false;

  @override
  void initState() {
    super.initState();

    _urlController.addListener(() {
      setState(() {
        _validForm = _urlController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _urlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Demandez votre tracking ID".toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 8.0,
          ),
          child: TextField(
            controller: _urlController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'URL de votre site',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: SizedBox(
            height: 40.0,
            child: ElevatedButton(
              onPressed: _validForm
                  ? () => context.read<GenerateTrackerBloc>().add(
                        OnGenerateTrackerEvent(
                          url: _urlController.text,
                        ),
                      )
                  : null,
              child: const Text("Demander un code"),
            ),
          ),
        ),
      ],
    );
  }
}
