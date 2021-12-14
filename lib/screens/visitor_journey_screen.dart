import 'package:atrap_io/models/event_model.dart';
import 'package:atrap_io/models/visitor_journey_model.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

VisitorJourneyModel visitorJourneyModel = VisitorJourneyModel.fromJson({
  "email": "john@domain.tld",
  "eventModelList": [
    EventModel(
      event: "Event 3",
      date: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    EventModel(
      event: "Event 2",
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    EventModel(
      event: "Event 1",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ]
});

class VisitorJourneyScreen extends StatelessWidget {
  static const routeName = '/visitor-journey';

  const VisitorJourneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Journey'),
      ),
      body: ListView.builder(
        itemCount: visitorJourneyModel.eventModelList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(),
            title: Text(visitorJourneyModel.eventModelList[index].event),
            subtitle: Text(
                timeago.format(visitorJourneyModel.eventModelList[index].date)),
          );
        },
      ),
    );
  }
}
