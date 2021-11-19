import 'package:equatable/equatable.dart';

class LinkModel extends Equatable {
  final String uid;
  final String src;
  final String source;
  final String type;
  final String name;
  final String linkId;
  final String params;

  const LinkModel({
    required this.uid,
    required this.src,
    this.source = "",
    this.type = "",
    this.name = "",
    this.linkId = "",
    this.params = "",
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "src": src,
        "source": source,
        "type": type,
        "name": name,
        "linkId": linkId,
        "params": params,
      };

  LinkModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] ?? "",
        src = json['src'] ?? "",
        source = json['source'] ?? "",
        type = json['type'] ?? "",
        name = json['name'] ?? "",
        linkId = json['linkId'] ?? "",
        params = json['params'] ?? "";

  @override
  List<Object?> get props => [
        uid,
        src,
        source,
        type,
        name,
        linkId,
        params,
      ];
}
