import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_navigation_event.dart';
part 'main_navigation_state.dart';

class MainNavigationBloc
    extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(const MainNavigationInitialState(0)) {
    on<OnNavigateEvent>((event, emit) {
      emit(MainNavigationInitialState(event.index));
    });
  }
}
