import 'package:cloud_firestore/cloud_firestore.dart';

class VisitModel {
  final String uid;
  final Map<String, dynamic> data;
  final Map<String, dynamic> queries;
  final DateTime timestamp;

  const VisitModel({
    required this.uid,
    required this.data,
    required this.queries,
    required this.timestamp,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      uid: json['uid'],
      data: json['data'],
      queries: json['queries'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'data': data,
      'queries': queries,
      'timestamp': timestamp,
    };
  }
}
