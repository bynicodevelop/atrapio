import 'package:equatable/equatable.dart';

class LinkModel extends Equatable {
  final String uid;
  final String src;
  final String utmSource;
  final String utmMedium;
  final String utmCampaign;
  final String utmId;
  final String utmTerm;
  final String utmContent;
  final String linkId;
  final String params;

  const LinkModel({
    required this.uid,
    required this.src,
    this.utmSource = "",
    this.utmMedium = "",
    this.utmCampaign = "",
    this.utmId = "",
    this.utmTerm = "",
    this.utmContent = "",
    this.linkId = "",
    this.params = "",
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "src": src,
        "utm_source": utmSource,
        "utm_medium": utmMedium,
        "utm_campaign": utmCampaign,
        "utm_id": utmId,
        "utm_term": utmTerm,
        "utm_content": utmContent,
        "linkId": linkId,
        "params": params,
      };

  LinkModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? "",
        src = json['src'] ?? "",
        utmSource = json['utm_source'] ?? "",
        utmMedium = json['utm_medium'] ?? "",
        utmCampaign = json['utm_campaign'] ?? "",
        utmId = json['utm_id'] ?? "",
        utmTerm = json['utm_term'] ?? "",
        utmContent = json['utm_content'] ?? "",
        linkId = json['linkId'] ?? "",
        params = json['params'] ?? "";

  @override
  List<Object?> get props => [
        uid,
        src,
        utmSource,
        utmMedium,
        utmCampaign,
        utmId,
        utmTerm,
        utmContent,
        linkId,
        params,
      ];
}