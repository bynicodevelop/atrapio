import 'package:equatable/equatable.dart';

class TrackingIdModel extends Equatable {
  final String trackingId;
  final String url;

  const TrackingIdModel({
    required this.trackingId,
    required this.url,
  });

  bool isEmpty() => trackingId.isEmpty;

  static TrackingIdModel empty() => const TrackingIdModel(
        trackingId: '',
        url: '',
      );

  factory TrackingIdModel.fromJson(Map<String, dynamic> json) {
    return TrackingIdModel(
      trackingId: json['trackingId'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trackingId': trackingId,
      'url': url,
    };
  }

  @override
  List<Object> get props => [
        trackingId,
        url,
      ];
}
