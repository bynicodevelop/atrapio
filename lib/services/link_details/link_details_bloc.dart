import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'link_details_event.dart';
part 'link_details_state.dart';

class LinkDetailsBloc extends Bloc<LinkDetailsEvent, LinkDetailsState> {
  final LinkRepository linkRepository;
  final AuthenticationRepository authenticationRepository;

  LinkDetailsBloc({
    required this.linkRepository,
    required this.authenticationRepository,
  }) : super(LinkDetailsInitialState()) {
    on<OnLinkDetailsEvent>((event, emit) async {
      emit(LinkDetailsLoadingState());

      try {
        LinkModel linkModel = await linkRepository.getLinkById({
          "userId": authenticationRepository.userId,
          "linkId": event.linkId,
        });

        emit(LinkDetailsLoadedState(linkModel));
      } catch (e) {
        emit(LinkDetailsErrorState(e.toString()));
      }
    });
  }
}
