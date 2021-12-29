import 'package:atrap_io/models/optin_model.dart';
import 'package:atrap_io/models/optin_param_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum typeLinkEnum { short, optinLink }

class LinkModel extends Equatable {
  final String uid;
  final String name;
  final String src;
  final String utmSource;
  final String utmMedium;
  final String utmCampaign;
  final String utmId;
  final String utmTerm;
  final String utmContent;
  final String linkId;
  final String params;
  final int clicks;
  final OptinModel? optinModel;
  final OptinParamModel? optinParamModel;
  final typeLinkEnum typeLink;
  final Map<String, dynamic> metadata;
  final Map<String, dynamic> stats;
  final DateTime? createdAt;

  const LinkModel({
    required this.uid,
    required this.src,
    required this.typeLink,
    this.optinModel,
    this.optinParamModel,
    this.name = "",
    this.utmSource = "",
    this.utmMedium = "",
    this.utmCampaign = "",
    this.utmId = "",
    this.utmTerm = "",
    this.utmContent = "",
    this.linkId = "",
    this.params = "",
    this.metadata = const {},
    this.stats = const {},
    this.clicks = 0,
    this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "src": src,
        "type_link": typeLink.toString(),
        "name": name,
        "created_at": createdAt,
        "utm_source": utmSource,
        "utm_medium": utmMedium,
        "utm_campaign": utmCampaign,
        "utm_id": utmId,
        "utm_term": utmTerm,
        "utm_content": utmContent,
        "linkId": linkId,
        "metadata": metadata,
        "stats": stats,
        "clicks": clicks,
        "params": params,
        "optin_model": optinModel?.toJson(),
        "optin_param_model": optinParamModel?.toJson(),
      };

  LinkModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? "",
        src = json['src'] ?? "",
        typeLink = json['type_link'] != null
            ? typeLinkEnum.values.firstWhere(
                (element) => element.toString() == json['type_link'].toString(),
                orElse: () => typeLinkEnum.short,
              )
            : typeLinkEnum.short,
        optinModel = json['optin_model'] != null
            ? OptinModel.fromJson(json['optin_model'])
            : null,
        optinParamModel = json['optin_param_model'] != null
            ? OptinParamModel.fromJson(json['optin_param_model'])
            : null,
        name = json['name'] ?? "",
        createdAt = json['created_at'] == null
            ? null
            : DateTime.fromMicrosecondsSinceEpoch(
                (json['created_at'] as Timestamp).microsecondsSinceEpoch,
              ),
        utmSource = json['utm_source'] ?? "",
        utmMedium = json['utm_medium'] ?? "",
        utmCampaign = json['utm_campaign'] ?? "",
        utmId = json['utm_id'] ?? "",
        utmTerm = json['utm_term'] ?? "",
        utmContent = json['utm_content'] ?? "",
        linkId = json['linkId'] ?? "",
        params = json['params'] ?? "",
        clicks = json['clicks'] ?? 0,
        metadata = json['metadata'] ?? {},
        stats = json['stats'] ?? {};

  @override
  List<Object?> get props => [
        uid,
        src,
        optinModel,
        optinParamModel,
        name,
        createdAt,
        utmSource,
        utmMedium,
        utmCampaign,
        utmId,
        utmTerm,
        utmContent,
        linkId,
        params,
        metadata,
        stats,
        clicks,
      ];
}
