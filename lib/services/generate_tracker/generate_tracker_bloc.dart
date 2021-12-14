import 'package:atrap_io/models/tracking_id_model.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/tracker_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'generate_tracker_event.dart';
part 'generate_tracker_state.dart';

class GenerateTrackerBloc
    extends Bloc<GenerateTrackerEvent, GenerateTrackerState> {
  final TrackerRepository trackerRepository;
  final AuthenticationRepository authenticationRepository;

  GenerateTrackerBloc({
    required this.trackerRepository,
    required this.authenticationRepository,
  }) : super(GenerateTrackerInitial()) {
    on<OnGenerateTrackerLoadingEvent>((event, emit) async {
      emit(GenerateTrackerLoadingState());

      try {
        TrackingIdModel trackingIdModel =
            await trackerRepository.trackingId(authenticationRepository.userId);

        emit(GenerateTrackerSuccessState(
          trackingIdModel: trackingIdModel,
        ));
      } catch (e) {
        emit(GenerateTrackerErrorState(e.toString()));
      }
    });

    on<OnGenerateTrackerEvent>((event, emit) async {
      emit(GenerateTrackerLoadingState());

      try {
        TrackingIdModel trackingIdModel =
            await trackerRepository.generateTrackingId(
          event.url,
        );

        emit(GenerateTrackerSuccessState(
          trackingIdModel: trackingIdModel,
        ));
      } catch (e) {
        emit(GenerateTrackerErrorState(e.toString()));
      }
    });
  }
}
