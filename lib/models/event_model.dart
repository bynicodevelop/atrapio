import 'package:equatable/equatable.dart';

class EventModel extends Equatable {
  final String event;
  final DateTime date;

  const EventModel({
    required this.event,
    required this.date,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      event: json['event'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event,
      'date': date,
    };
  }

  @override
  List<Object> get props => [
        event,
        date,
      ];
}
