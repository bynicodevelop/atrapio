import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_link_event.dart';
part 'get_link_state.dart';

class GetLinkBloc extends Bloc<GetLinkEvent, GetLinkState> {
  final LinkRepository linkRepository;
  final AuthenticationRepository authenticationRepository;

  GetLinkBloc(
    this.linkRepository,
    this.authenticationRepository,
  ) : super(
          GetLinkInitialState(
            linkModel: LinkModel.empty(),
          ),
        ) {
    on<OnGetLinkEvent>((event, emit) async {
      emit(GetLinkLoadingState());

      // try {
      LinkModel linkModel = await linkRepository.getLinkByUid(
        event.uid,
        authenticationRepository.userId,
      );

      emit(GetLinkInitialState(
        linkModel: linkModel,
      ));
      // } catch (e) {
      //   emit(GetLinkFailureState(e.toString()));
      // }
    });
  }
}
