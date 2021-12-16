part of 'link_details_bloc.dart';

abstract class LinkDetailsState extends Equatable {
  const LinkDetailsState();

  @override
  List<Object> get props => [];
}

class LinkDetailsInitialState extends LinkDetailsState {}

class LinkDetailsLoadingState extends LinkDetailsState {}

class LinkDetailsLoadedState extends LinkDetailsState {
  final LinkModel linkModel;

  const LinkDetailsLoadedState(
    this.linkModel,
  );

  @override
  List<Object> get props => [
        linkModel,
      ];
}

class LinkDetailsErrorState extends LinkDetailsState {
  final String errorMessage;

  const LinkDetailsErrorState(this.errorMessage);

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
