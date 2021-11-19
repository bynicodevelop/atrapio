part of 'add_link_bloc.dart';

abstract class AddLinkEvent extends Equatable {
  const AddLinkEvent();

  @override
  List<Object> get props => [];
}

class OnCreateLinkEvent extends AddLinkEvent {
  final Map<String, dynamic> params;

  const OnCreateLinkEvent({
    required this.params,
  });

  @override
  List<Object> get props => [
        params,
      ];
}
