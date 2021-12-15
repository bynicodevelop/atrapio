part of 'generate_tracker_bloc.dart';

abstract class GenerateTrackerEvent extends Equatable {
  const GenerateTrackerEvent();

  @override
  List<Object> get props => [];
}

class OnGenerateTrackerLoadingEvent extends GenerateTrackerEvent {}

class OnGenerateTrackerEvent extends GenerateTrackerEvent {
  final String url;

  const OnGenerateTrackerEvent({
    required this.url,
  });

  @override
  List<Object> get props => [
        url,
      ];
}
