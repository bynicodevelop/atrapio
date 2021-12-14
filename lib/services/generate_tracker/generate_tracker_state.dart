part of 'generate_tracker_bloc.dart';

abstract class GenerateTrackerState extends Equatable {
  const GenerateTrackerState();

  @override
  List<Object> get props => [];
}

class GenerateTrackerInitial extends GenerateTrackerState {}

class GenerateTrackerLoadingState extends GenerateTrackerState {}

class GenerateTrackerSuccessState extends GenerateTrackerState {
  final TrackingIdModel trackingIdModel;

  const GenerateTrackerSuccessState({
    required this.trackingIdModel,
  });

  @override
  List<Object> get props => [
        trackingIdModel,
      ];
}

class GenerateTrackerErrorState extends GenerateTrackerState {
  final String error;

  const GenerateTrackerErrorState(this.error);

  @override
  List<Object> get props => [error];
}
