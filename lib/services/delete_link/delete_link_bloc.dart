import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_link_event.dart';
part 'delete_link_state.dart';

class DeleteLinkBloc extends Bloc<DeleteLinkEvent, DeleteLinkState> {
  final LinkRepository linkRepository;

  DeleteLinkBloc(
    this.linkRepository,
  ) : super(DeleteLinkInitial()) {
    on<OnDeleteLinkEvent>((event, emit) {
      emit(DeleteLinkLoadingState());

      try {
        linkRepository.deleteLink(
          event.link,
        );

        emit(DeleteLinkSuccessState());
      } catch (e) {
        emit(DeleteLinkFailureState(e.toString()));
      }
    });
  }
}
