import 'package:atrap_io/components/card_list_link_component.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Should check labels", (WidgetTester tester) async {
    final LinkModel link = LinkModel.fromJson(const {
      "uid": "uid",
      "src": "https://www.nico-develop.com",
      "name": "Nico Develop",
      "clicks": 10,
    });
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CardListLinkComponent(link: link, actions: const []),
      ),
    ));

    expect(find.text('Clicks : 10'), findsOneWidget);
    expect(find.text('Nico Develop'), findsOneWidget);
    expect(find.text('https://www.nico-develop.com'), findsOneWidget);
  });
}
