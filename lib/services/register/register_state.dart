part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final String error;

  const RegisterFailureState({
    required this.error,
  });

  @override
  List<Object> get props => [
        error,
      ];

  @override
  String toString() => 'RegisterFailedState { error: $error }';
}
