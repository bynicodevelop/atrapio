import 'package:atrap_io/components/text_fields/url_text_field/bloc/url_text_field_bloc.dart';
import 'package:atrap_io/components/text_fields/url_text_field/url_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should expect an error with empty url",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UrlTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: UrlTextField(
              controller: controller,
              labelText: "labelText",
              errorText: "errorText",
              required: true,
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

  testWidgets("Should expect an error with invalid url",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UrlTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: UrlTextField(
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
      'test',
    );

    await tester.pumpAndSettle();

    // ASSERT
    expect(
      find.text('errorText'),
      findsOneWidget,
    );

    expect(valueExpected, true);
  });

  testWidgets("Should not expect an error with valid url",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UrlTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: UrlTextField(
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
      'https://nico-develop.com',
    );

    await tester.pumpAndSettle();

    // ASSERT
    expect(
      find.text('errorText'),
      findsNothing,
    );

    expect(valueExpected, false);
  });

  testWidgets("Should not expect an error with empty url and is not required",
      (WidgetTester tester) async {
    // ARRANGE
    bool valueExpected = false;
    final TextEditingController controller = TextEditingController();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UrlTextFieldBloc(),
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: UrlTextField(
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
}
