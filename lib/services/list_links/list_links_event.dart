part of 'list_links_bloc.dart';

abstract class ListLinksEvent extends Equatable {
  const ListLinksEvent();

  @override
  List<Object> get props => [];
}

class OnLoadListLinksEvent extends ListLinksEvent {}

class _OnLoadedListLinksEvent extends ListLinksEvent {
  final int refresh;
  final List<LinkModel> links;

  const _OnLoadedListLinksEvent({
    required this.refresh,
    required this.links,
  });

  @override
  List<Object> get props => [
        links,
        refresh,
      ];
}
