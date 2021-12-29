part of 'link_editor_bloc.dart';

abstract class LinkEditorEvent extends Equatable {
  const LinkEditorEvent();

  @override
  List<Object> get props => [];
}

class OnLinkEditorInitializeEvent extends LinkEditorEvent {}

class OnLinkEditorUpdatedEvent extends LinkEditorEvent {
  final Map<String, dynamic> data;

  const OnLinkEditorUpdatedEvent({
    required this.data,
  });

  @override
  List<Object> get props => [
        data,
      ];
}

class OnPreviewLinkEditorEvent extends LinkEditorEvent {}

class OnSaveLinkEditorEvent extends LinkEditorEvent {}
