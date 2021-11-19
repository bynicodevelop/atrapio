part of 'main_navigation_bloc.dart';

abstract class MainNavigationState extends Equatable {
  const MainNavigationState();

  @override
  List<Object> get props => [];
}

class MainNavigationInitialState extends MainNavigationState {
  final int currentIndex;

  const MainNavigationInitialState(this.currentIndex);

  @override
  List<Object> get props => [
        currentIndex,
      ];
}
