part of 'update_link_bloc.dart';

abstract class UpdateLinkState extends Equatable {
  const UpdateLinkState();

  @override
  List<Object> get props => [];
}

class UpdateLinkInitial extends UpdateLinkState {}

class UpdateLinkLoadingState extends UpdateLinkState {}

class UpdateLinkSuccessState extends UpdateLinkState {
  final int refresh;

  const UpdateLinkSuccessState({
    required this.refresh,
  });

  @override
  List<Object> get props => [
        refresh,
      ];
}

class UpdateLinkErrorState extends UpdateLinkState {
  final String error;

  const UpdateLinkErrorState(this.error);

  @override
  List<Object> get props => [
        error,
      ];
}
