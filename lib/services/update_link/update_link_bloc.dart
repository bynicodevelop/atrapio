import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_link_event.dart';
part 'update_link_state.dart';

class UpdateLinkBloc extends Bloc<UpdateLinkEvent, UpdateLinkState> {
  final LinkRepository linkRepository;
  final AuthenticationRepository authenticationRepository;

  UpdateLinkBloc({
    required this.linkRepository,
    required this.authenticationRepository,
  }) : super(UpdateLinkInitial()) {
    on<UpdateLinkModelEvent>((event, emit) async {
      emit(UpdateLinkLoadingState());

      try {
        await linkRepository.updateLink(
          {
            ...event.linkData,
            ...{
              "userId": authenticationRepository.userId,
            }
          },
        );

        emit(UpdateLinkSuccessState(
          refresh: DateTime.now().microsecondsSinceEpoch,
        ));
      } catch (e) {
        emit(UpdateLinkErrorState(
          e.toString(),
        ));
      }
    });
  }
}
