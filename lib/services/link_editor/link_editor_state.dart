part of 'link_editor_bloc.dart';

abstract class LinkEditorState extends Equatable {
  const LinkEditorState();

  @override
  List<Object> get props => [];
}

class LinkEditorInitialState extends LinkEditorState {
  final int currentIndex;
  final String src;
  final String utmSource;
  final String utmMedium;
  final String utmCampaign;
  final String utmId;
  final String utmTerm;
  final String utmContent;
  final String params;
  final typeLinkEnum typeLink;
  final OptinModel? optinModel;
  final OptinParamModel? optinParamModel;

  const LinkEditorInitialState({
    this.currentIndex = 0,
    this.src = "",
    this.utmSource = "",
    this.utmMedium = "",
    this.utmCampaign = "",
    this.utmId = "",
    this.utmTerm = "",
    this.utmContent = "",
    this.params = "",
    this.typeLink = typeLinkEnum.short,
    this.optinModel,
    this.optinParamModel,
  });

  LinkEditorInitialState copyWith({
    int? newCurrentIndex,
    String? newSrc,
    String? newUtmSource,
    String? newUtmMedium,
    String? newUtmCampaign,
    String? newUtmId,
    String? newUtmTerm,
    String? newUtmContent,
    String? newParams,
    typeLinkEnum? newTypeLink,
    OptinModel? newOptinModel,
    OptinParamModel? newOptinParamModel,
  }) {
    return LinkEditorInitialState(
      currentIndex: newCurrentIndex ?? currentIndex,
      src: newSrc ?? src,
      utmSource: newUtmSource ?? utmSource,
      utmMedium: newUtmMedium ?? utmMedium,
      utmCampaign: newUtmCampaign ?? utmCampaign,
      utmId: newUtmId ?? utmId,
      utmTerm: newUtmTerm ?? utmTerm,
      utmContent: newUtmContent ?? utmContent,
      params: newParams ?? params,
      typeLink: newTypeLink ?? typeLink,
      optinModel: newOptinModel ?? optinModel,
      optinParamModel: newOptinParamModel ?? optinParamModel,
    );
  }

  Map<String, dynamic> toJson() => {
        "currentIndex": currentIndex,
        "src": src,
        "utm_source": utmSource,
        "utm_medium": utmMedium,
        "utm_campaign": utmCampaign,
        "utm_id": utmId,
        "utm_term": utmTerm,
        "utm_content": utmContent,
        "params": params,
        "type_link": typeLink.toString(),
        "optin_model": optinModel?.toJson(),
        "optin_param_model": optinParamModel?.toJson(),
      };

  @override
  List<Object> get props => [
        currentIndex,
        src,
        typeLink,
        utmSource,
        utmMedium,
        utmCampaign,
        utmId,
        utmTerm,
        utmContent,
        params,
      ];
}

class LinkEditorNextState extends LinkEditorState {
  final int currentIndex;
  final int refresh;

  const LinkEditorNextState({
    this.currentIndex = 0,
    this.refresh = 0,
  });

  @override
  List<Object> get props => [
        currentIndex,
        refresh,
      ];
}
