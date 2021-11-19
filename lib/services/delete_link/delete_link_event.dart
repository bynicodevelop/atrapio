part of 'delete_link_bloc.dart';

abstract class DeleteLinkEvent extends Equatable {
  const DeleteLinkEvent();

  @override
  List<Object> get props => [];
}

class OnDeleteLinkEvent extends DeleteLinkEvent {
  final LinkModel link;

  const OnDeleteLinkEvent(
    this.link,
  );

  @override
  List<Object> get props => [
        link,
      ];
}
