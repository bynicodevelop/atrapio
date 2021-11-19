import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterBloc({
    required this.authenticationRepository,
  }) : super(RegisterInitial()) {
    on<RegisterSubmitEvent>((event, emit) async {
      emit(RegisterLoadingState());

      try {
        await authenticationRepository.signUpWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        emit(RegisterSuccessState());
      } on AuthenticationException catch (e) {
        emit(RegisterFailureState(error: e.message));
      }
    });
  }
}
