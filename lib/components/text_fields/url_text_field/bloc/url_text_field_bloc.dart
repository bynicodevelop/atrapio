import 'package:atrap_io/validators/url_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'url_text_field_event.dart';
part 'url_text_field_state.dart';

class UrlTextFieldBloc extends Bloc<UrlTextFieldEvent, UrlTextFieldState> {
  UrlTextFieldBloc() : super(const UrlTextFieldInitialState()) {
    on<OnUrlTextFieldChangedEvent>((event, emit) {
      final UrlValidator url = UrlValidator.dirty(event.url);

      emit(UrlTextFieldInitialState(
        url: event.url,
        isValid: url.valid ? UrlTextFieldEnum.valid : UrlTextFieldEnum.invalid,
      ));
    });
  }
}
