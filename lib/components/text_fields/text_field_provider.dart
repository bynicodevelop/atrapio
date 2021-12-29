import 'package:atrap_io/components/text_fields/input_text_field/bloc/input_text_field_bloc.dart';
import 'package:atrap_io/components/text_fields/text_field_form/text_field_form_bloc.dart';
import 'package:atrap_io/components/text_fields/url_text_field/bloc/url_text_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldProvider extends StatelessWidget {
  final Widget child;

  const TextFieldProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextFieldFormBloc>(
          create: (context) => TextFieldFormBloc(),
        ),
        BlocProvider<UrlTextFieldBloc>(
          create: (context) => UrlTextFieldBloc(),
        ),
        BlocProvider<InputTextFieldBloc>(
          create: (context) => InputTextFieldBloc(),
        ),
      ],
      child: child,
    );
  }
}
