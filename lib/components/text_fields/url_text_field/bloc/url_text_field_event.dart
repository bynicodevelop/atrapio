part of 'url_text_field_bloc.dart';

abstract class UrlTextFieldEvent extends Equatable {
  const UrlTextFieldEvent();

  @override
  List<Object> get props => [];
}

class OnUrlTextFieldChangedEvent extends UrlTextFieldEvent {
  final String url;

  const OnUrlTextFieldChangedEvent({
    required this.url,
  });

  @override
  List<Object> get props => [
        url,
      ];
}
