import 'package:atrap_io/models/metadata_model.dart';
import 'package:atrap_io/models/visit_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final DateTime? createdAt;
  final List<VisitModel> visits;
  final MetadataModel? metadata;

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
    this.createdAt,
    this.visits = const [],
    this.metadata,
  });

  factory LinkModel.empty() => const LinkModel(
        uid: "",
        src: "",
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "src": src,
        "created_at": createdAt,
        "utm_source": utmSource,
        "utm_medium": utmMedium,
        "utm_campaign": utmCampaign,
        "utm_id": utmId,
        "utm_term": utmTerm,
        "utm_content": utmContent,
        "linkId": linkId,
        "params": params,
        "visits": visits,
        "metadata": metadata == null ? null : metadata!.toJson(),
      };

  LinkModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? "",
        src = json['src'] ?? "",
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
        visits = json['visits'] ?? [],
        metadata = json['metadata'] == null
            ? null
            : MetadataModel.fromJson(json['metadata'] ?? {});

  @override
  List<Object?> get props => [
        uid,
        src,
        createdAt,
        utmSource,
        utmMedium,
        utmCampaign,
        utmId,
        utmTerm,
        utmContent,
        linkId,
        params,
        visits,
        metadata,
      ];
}
