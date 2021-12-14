import 'package:atrap_io/components/generate_tracking_id_form.dart';
import 'package:atrap_io/config/constants.dart';
import 'package:atrap_io/helpers/translate.dart';
import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/services/generate_tracker/generate_tracker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GetTrackerScreen extends StatefulWidget {
  static const routeName = '/get-tracker';

  const GetTrackerScreen({Key? key}) : super(key: key);

  @override
  State<GetTrackerScreen> createState() => _GetTrackerScreenState();
}

class _GetTrackerScreenState extends State<GetTrackerScreen> {
  final TextEditingController _trackingScriptController =
      TextEditingController();
  final TextEditingController _trackingScriptEventController =
      TextEditingController();

  String _trackingScript(String trackingId) =>
      """<script src="$kDomain$kPathTracker/index.min.js"></script>

<script>
  settings({
    trackingId: "A.I-$trackingId"
  });
</script>""";

  String _trackingScriptEvent() => """<script>
  tracker({
    event: 'EVENT_NAME',
    value: 'VALUE', // optional
  });
</script>""";

  Widget _trackingIdInstall(GenerateTrackerSuccessState state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10.0,
            ),
            child: Text(
              t(context)!.trackingIdTitleConfigureTracker,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10.0,
            ),
            child: Text(
              t(context)!.trackingIdInstruction,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 8.0,
            ),
            child: TextField(
              enableInteractiveSelection: false,
              controller: _trackingScriptController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: t(context)!.trackingIdTextFieldLabel,
                suffixIcon: IconButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: _trackingScript(
                          state.trackingIdModel.trackingId,
                        ),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t(context)!.trackingIdCopiedMessage),
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.copy,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10.0,
            ),
            child: Text(
              t(context)!.trackingIdTitleConfigureEvent,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10.0,
            ),
            child: Text(
              t(context)!.trackingIdInstructionEvent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10.0,
            ),
            child: Text(
              t(context)!.trackingIdInstructionValue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 8.0,
            ),
            child: TextField(
              enableInteractiveSelection: false,
              controller: _trackingScriptEventController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: t(context)!.trackingIdTextFieldLabelEvent,
                helperText: t(context)!.trackingIdTextFieldHelperEvent,
                helperMaxLines: 2,
                suffixIcon: IconButton(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(
                        text: _trackingScriptEvent(),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t(context)!.trackingIdCopiedMessage),
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.copy,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );

  Widget _wrapper({
    required Widget child,
    int width = 800,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context)
              ? 0
              : (MediaQuery.of(context).size.width - width) / 2,
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking ID'),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<GenerateTrackerBloc, GenerateTrackerState>(
          bloc: context.read<GenerateTrackerBloc>()
            ..add(OnGenerateTrackerLoadingEvent()),
          listener: (context, state) {
            if (state is GenerateTrackerSuccessState &&
                !state.trackingIdModel.isEmpty()) {
              _trackingScriptController.text = _trackingScript(
                state.trackingIdModel.trackingId,
              );

              _trackingScriptEventController.text = _trackingScriptEvent();
            }
          },
          builder: (context, state) {
            if (state is GenerateTrackerSuccessState) {
              return state.trackingIdModel.isEmpty()
                  ? _wrapper(
                      child: const GenerateTrackingIdForm(),
                      width: 400,
                    )
                  : _wrapper(
                      child: _trackingIdInstall(state),
                    );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
