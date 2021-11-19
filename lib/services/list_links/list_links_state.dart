part of 'list_links_bloc.dart';

abstract class ListLinksState extends Equatable {
  const ListLinksState();

  @override
  List<Object> get props => [];
}

class ListLinksInitialState extends ListLinksState {
  final int refresh;
  final List<LinkModel> links;

  const ListLinksInitialState({
    required this.links,
    required this.refresh,
  });

  @override
  List<Object> get props => [
        links,
        refresh,
      ];
}

class ListLinksReloadedState extends ListLinksState {
  final int refresh;

  const ListLinksReloadedState(
    this.refresh,
  );

  @override
  List<Object> get props => [
        refresh,
      ];
}
