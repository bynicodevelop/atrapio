part of 'get_link_bloc.dart';

abstract class GetLinkState extends Equatable {
  const GetLinkState();

  @override
  List<Object> get props => [];
}

class GetLinkLoadingState extends GetLinkState {}

class GetLinkFailureState extends GetLinkState {
  final String error;

  const GetLinkFailureState(
    this.error,
  );

  @override
  List<Object> get props => [
        error,
      ];
}

class GetLinkInitialState extends GetLinkState {
  final LinkModel linkModel;

  const GetLinkInitialState({
    required this.linkModel,
  });

  @override
  List<Object> get props => [
        linkModel,
      ];
}
