import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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
  final Map<String, dynamic> metadata;
  final Map<String, dynamic> stats;
  final DateTime? createdAt;

  const LinkModel({
    required this.uid,
    required this.src,
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
      };

  LinkModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? "",
        src = json['src'] ?? "",
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
