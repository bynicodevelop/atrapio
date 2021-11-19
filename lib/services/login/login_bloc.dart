import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({
    required this.authenticationRepository,
  }) : super(LoginInitial()) {
    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        await authenticationRepository.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        emit(LoginSuccessState());
      } on AuthenticationException catch (e) {
        emit(LoginFailureState(e.message));
      }
    });
  }
}
