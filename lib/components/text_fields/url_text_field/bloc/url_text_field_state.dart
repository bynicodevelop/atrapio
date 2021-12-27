part of 'url_text_field_bloc.dart';

enum UrlTextFieldEnum {
  valid,
  invalid,
  undefined,
}

abstract class UrlTextFieldState extends Equatable {
  const UrlTextFieldState();

  @override
  List<Object> get props => [];
}

class UrlTextFieldInitialState extends UrlTextFieldState {
  final String url;
  final UrlTextFieldEnum isValid;

  const UrlTextFieldInitialState({
    this.url = "",
    this.isValid = UrlTextFieldEnum.undefined,
  });

  @override
  List<Object> get props => [
        url,
        isValid,
      ];
}
