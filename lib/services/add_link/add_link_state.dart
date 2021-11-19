part of 'add_link_bloc.dart';

abstract class AddLinkState extends Equatable {
  const AddLinkState();

  @override
  List<Object> get props => [];
}

class AddLinkInitial extends AddLinkState {}

class AddLinkLoading extends AddLinkState {}

class AddLinkSuccess extends AddLinkState {}

class AddLinkFailure extends AddLinkState {
  final String error;

  const AddLinkFailure({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];
}
