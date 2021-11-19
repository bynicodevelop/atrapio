import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_links_event.dart';
part 'list_links_state.dart';

class ListLinksBloc extends Bloc<ListLinksEvent, ListLinksState> {
  final LinkRepository linkRepository;
  final AuthenticationRepository authenticationRepository;

  ListLinksBloc(
    this.linkRepository,
    this.authenticationRepository,
  ) : super(
          const ListLinksInitialState(
            links: [],
            refresh: 0,
          ),
        ) {
    linkRepository.links(authenticationRepository.userId).listen((links) {
      add(_OnLoadedListLinksEvent(
        refresh: DateTime.now().microsecondsSinceEpoch,
        links: links,
      ));
    });

    on<OnLoadListLinksEvent>((event, emit) async {
      List<LinkModel> links = await linkRepository
          .links(authenticationRepository.userId)
          .asyncMap((links) => links)
          .map((links) => links)
          .first;

      add(
        _OnLoadedListLinksEvent(
          refresh: DateTime.now().microsecondsSinceEpoch,
          links: links,
        ),
      );
    });

    on<_OnLoadedListLinksEvent>((event, emit) {
      emit(
        ListLinksInitialState(
          refresh: event.refresh,
          links: event.links,
        ),
      );
    });
  }
}
