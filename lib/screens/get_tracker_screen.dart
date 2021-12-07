import 'package:flutter/material.dart';

class GetTrackerScreen extends StatelessWidget {
  static const routeName = '/get-tracker';

  const GetTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tracking ID'),
      ),
      body: Column(children: []),
    );
  }
}
