import 'package:atrap_io/models/event_model.dart';
import 'package:equatable/equatable.dart';

class VisitorJourneyModel extends Equatable {
  final String email;
  final List<EventModel> eventModelList;

  const VisitorJourneyModel({
    required this.email,
    required this.eventModelList,
  });

  factory VisitorJourneyModel.fromJson(Map<String, dynamic> json) {
    return VisitorJourneyModel(
      email: json['email'] as String,
      eventModelList: (json['eventModelList'] as List<EventModel>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'visitorJourney': eventModelList,
    };
  }

  @override
  List<Object> get props => [
        email,
        eventModelList,
      ];
}
