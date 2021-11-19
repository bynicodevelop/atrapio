part of 'delete_link_bloc.dart';

abstract class DeleteLinkState extends Equatable {
  const DeleteLinkState();

  @override
  List<Object> get props => [];
}

class DeleteLinkInitial extends DeleteLinkState {}

class DeleteLinkLoadingState extends DeleteLinkState {}

class DeleteLinkSuccessState extends DeleteLinkState {}

class DeleteLinkFailureState extends DeleteLinkState {
  final String error;

  const DeleteLinkFailureState(
    this.error,
  );

  @override
  List<Object> get props => [
        error,
      ];
}
