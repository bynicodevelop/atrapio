part of 'main_navigation_bloc.dart';

abstract class MainNavigationEvent extends Equatable {
  const MainNavigationEvent();

  @override
  List<Object> get props => [];
}

class OnNavigateEvent extends MainNavigationEvent {
  final int index;

  const OnNavigateEvent(
    this.index,
  );

  @override
  List<Object> get props => [
        index,
      ];
}
