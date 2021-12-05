part of 'get_link_bloc.dart';

abstract class GetLinkEvent extends Equatable {
  const GetLinkEvent();

  @override
  List<Object> get props => [];
}

class OnGetLinkEvent extends GetLinkEvent {
  final String uid;

  const OnGetLinkEvent({
    required this.uid,
  });

  @override
  List<Object> get props => [
        uid,
      ];
}
