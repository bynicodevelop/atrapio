import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthenticationRepository authenticationRepository;

  LogoutBloc({
    required this.authenticationRepository,
  }) : super(LogoutInitial()) {
    on<LogoutSubmitEvent>((event, emit) async {
      await authenticationRepository.signOut();

      emit(LogoutSuccessState());
    });
  }
}
