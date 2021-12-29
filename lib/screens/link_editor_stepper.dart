import 'package:atrap_io/responsive.dart';
import 'package:atrap_io/screens/link_editors_views/customize_optin_link_view.dart';
import 'package:atrap_io/screens/link_editors_views/finalize_link_view.dart';
import 'package:atrap_io/screens/link_editors_views/optin_link_view.dart';
import 'package:atrap_io/screens/link_editors_views/options_link_view.dart';
import 'package:atrap_io/screens/link_editors_views/start_link_editor_view.dart';
import 'package:atrap_io/screens/link_editors_views/type_link_view.dart';
import 'package:atrap_io/services/link_editor/link_editor_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkEditorStepper extends StatefulWidget {
  static const String routeName = '/link_editor_stepper';

  const LinkEditorStepper({Key? key}) : super(key: key);

  @override
  State<LinkEditorStepper> createState() => _LinkEditorStepperState();
}

class _LinkEditorStepperState extends State<LinkEditorStepper> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const Text('Link Editor'),
      ),
      body: BlocConsumer<LinkEditorBloc, LinkEditorState>(
        bloc: context.read<LinkEditorBloc>()
          ..add(
            OnLinkEditorInitializeEvent(),
          ),
        listener: (context, state) {
          if (state is LinkEditorInitialState) {
            try {
              _pageController.jumpToPage(
                state.currentIndex,
              );
              // ignore: empty_catches
            } catch (e) {}
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context)
                  ? 8.0
                  : (MediaQuery.of(context).size.width - 400) / 2,
            ),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [
                StartLinkEditorView(),
                TypeLinkView(),
                OptinLinkView(),
                CustomizeOptinLinkView(),
                OptionsLinkView(),
                FinalizeLinkView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
