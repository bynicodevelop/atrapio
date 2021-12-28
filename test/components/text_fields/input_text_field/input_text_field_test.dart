import 'package:atrap_io/components/text_fields/input_text_field/bloc/input_text_field_bloc.dart';
import 'package:atrap_io/components/text_fields/input_text_field/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should expect un erreur when textfield is required",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InputTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: InputTextField(
              controller: controller,
              required: true,
              labelText: "labelText",
              errorText: "errorText",
              onChanged: (value) => valueExpected = value,
            ),
          ),
        ),
      ),
    );

    // ACT
    await tester.enterText(
      find.byType(TextField),
      '',
    );

    await tester.pumpAndSettle();

    // ASSERT
    expect(
      find.text('errorText'),
      findsOneWidget,
    );

    expect(valueExpected, true);
  });

  testWidgets("Should not expect erreur when is not required",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InputTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: InputTextField(
              controller: controller,
              labelText: "labelText",
              errorText: "errorText",
              onChanged: (value) => valueExpected = value,
            ),
          ),
        ),
      ),
    );

    // ACT
    await tester.enterText(
      find.byType(TextField),
      '',
    );

    await tester.pumpAndSettle();

    // ASSERT
    expect(
      find.text('errorText'),
      findsNothing,
    );

    expect(valueExpected, true);
  });

  testWidgets("Should not expect erreur when is required",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => InputTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: InputTextField(
              controller: controller,
              required: true,
              labelText: "labelText",
              errorText: "errorText",
              onChanged: (value) => valueExpected = value,
            ),
          ),
        ),
      ),
    );

    // ACT
    await tester.enterText(
      find.byType(TextField),
      'coucou',
    );

    await tester.pumpAndSettle();

    // ASSERT
    expect(
      find.text('errorText'),
      findsNothing,
    );

    expect(valueExpected, false);
  });
}
