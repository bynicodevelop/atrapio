part of 'update_link_bloc.dart';

abstract class UpdateLinkEvent extends Equatable {
  const UpdateLinkEvent();

  @override
  List<Object> get props => [];
}

class UpdateLinkModelEvent extends UpdateLinkEvent {
  final Map<String, dynamic> linkData;

  const UpdateLinkModelEvent({
    required this.linkData,
  });

  @override
  List<Object> get props => [
        linkData,
      ];
}
