import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/models/optin_model.dart';
import 'package:atrap_io/models/optin_param_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'link_editor_event.dart';
part 'link_editor_state.dart';

class LinkEditorBloc extends Bloc<LinkEditorEvent, LinkEditorState> {
  int _currentIndex = 0;

  LinkEditorBloc() : super(const LinkEditorInitialState()) {
    on<OnLinkEditorInitializeEvent>((event, emit) {
      _currentIndex = 0;

      emit(LinkEditorInitialState(
        currentIndex: _currentIndex,
      ));
    });

    on<OnLinkEditorUpdatedEvent>((event, emit) {
      if (_currentIndex == 0) {
        _currentIndex = 1;
      } else if (_currentIndex == 1) {
        _currentIndex =
            event.data["type_link"] == typeLinkEnum.optinLink ? 2 : 4;
      } else if (_currentIndex == 2) {
        _currentIndex = 3;
      } else if (_currentIndex == 3) {
        _currentIndex = 4;
      } else {
        _currentIndex = 5;
      }

      LinkEditorInitialState newLinkState =
          (state as LinkEditorInitialState).copyWith(
        newCurrentIndex: _currentIndex,
        newSrc: event.data["src"] ?? (state as LinkEditorInitialState).src,
        newUtmSource: event.data["utm_source"] ??
            (state as LinkEditorInitialState).utmSource,
        newUtmMedium: event.data["utm_medium"] ??
            (state as LinkEditorInitialState).utmMedium,
        newUtmCampaign: event.data["utm_campaign"] ??
            (state as LinkEditorInitialState).utmCampaign,
        newUtmId:
            event.data["utm_id"] ?? (state as LinkEditorInitialState).utmId,
        newUtmTerm:
            event.data["utm_term"] ?? (state as LinkEditorInitialState).utmTerm,
        newUtmContent: event.data["utm_content"] ??
            (state as LinkEditorInitialState).utmContent,
        newParams:
            event.data["params"] ?? (state as LinkEditorInitialState).params,
        newTypeLink: event.data['type_link'] != null
            ? typeLinkEnum.values.firstWhere(
                (element) =>
                    element.toString() == event.data['type_link'].toString(),
                orElse: () => typeLinkEnum.short,
              )
            : (state as LinkEditorInitialState).typeLink,
        newOptinModel: event.data["optin_model"] ??
            (state as LinkEditorInitialState).optinModel,
        newOptinParamModel: event.data["optin_param_model"] ??
            (state as LinkEditorInitialState).optinParamModel,
      );

      emit(newLinkState);
    });

    on<OnPreviewLinkEditorEvent>((event, emit) {
      _currentIndex -= 1;

      LinkEditorInitialState newLinkState =
          (state as LinkEditorInitialState).copyWith(
        newCurrentIndex: _currentIndex,
      );

      emit(newLinkState);
    });
  }
}
