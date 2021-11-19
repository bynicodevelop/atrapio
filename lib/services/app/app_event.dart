part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStateChangedEvent extends AppEvent {
  final UserModel user;

  const AppStateChangedEvent(this.user);

  @override
  List<Object> get props => [
        user,
      ];
}
