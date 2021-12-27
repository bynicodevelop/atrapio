import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_link_event.dart';
part 'add_link_state.dart';

class AddLinkBloc extends Bloc<AddLinkEvent, AddLinkState> {
  final LinkRepository linkRepository;
  final AuthenticationRepository authenticationRepository;

  AddLinkBloc({
    required this.linkRepository,
    required this.authenticationRepository,
  }) : super(AddLinkInitial()) {
    on<OnCreateLinkEvent>((event, emit) async {
      Map<String, String> metadata = {};
      emit(AddLinkLoading());

      // try {
      String linkId = await linkRepository.getTemporaryLink();

      await linkRepository.createLink(
        {
          ...event.params,
          ...{
            "name": metadata["title"],
            "userId": authenticationRepository.userId,
            "linkId": linkId,
            "metadata": metadata,
          },
        },
      );

      emit(AddLinkSuccess());
      // } catch (e) {
      //   // TODO: Add crash analytics
      //   emit(AddLinkFailure(
      //     error: e.toString(),
      //   ));
      // }
    });
  }
}
