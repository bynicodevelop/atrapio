part of 'link_details_bloc.dart';

abstract class LinkDetailsEvent extends Equatable {
  const LinkDetailsEvent();

  @override
  List<Object> get props => [];
}

class OnLinkDetailsEvent extends LinkDetailsEvent {
  final String linkId;

  const OnLinkDetailsEvent({
    required this.linkId,
  });

  @override
  List<Object> get props => [
        linkId,
      ];
}
