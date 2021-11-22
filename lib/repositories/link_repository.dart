import 'package:atrap_io/exceptions/link_exception.dart';
import 'package:atrap_io/helpers/link_helper.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class LinkRepository {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;

  const LinkRepository({
    required this.firestore,
    required this.functions,
  });

  Stream<List<LinkModel>> links(String userId) => firestore
      .collection("users")
      .doc(userId)
      .collection("links")
      .orderBy(
        "created_at",
        descending: true,
      )
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .map(
              (doc) => LinkModel.fromJson({
                ...doc.data(),
                ...{"uid": doc.id}
              }),
            )
            .toList(),
      );

  Future<void> createLink(Map<String, dynamic> params) async {
    if (params["userId"].toString().isEmpty) {
      throw LinkException(LinkException.userIdRequired);
    }

    if (params["src"].toString().isEmpty) {
      throw LinkException(LinkException.urlIsRequired);
    }

    if (params["linkId"].toString().isEmpty) {
      throw LinkException(LinkException.linkIdIsRequired);
    }

    final LinkHelper linkHelper = LinkHelper();

    String link = linkHelper.linkFactory(params);

    if (link.isNotEmpty) {
      params["src"] = link;
    }

    LinkModel linkModel = LinkModel.fromJson(params);

    await firestore
        .collection("users")
        .doc(params["userId"])
        .collection("links")
        .doc(params["linkId"])
        .set(
          linkModel.toJson(),
        );
  }

  Future<String> getTemporaryLink() async {
    HttpsCallable httpsCallable =
        functions.httpsCallable("generateTemporaryUniqueId");

    HttpsCallableResult httpsCallableResult = await httpsCallable.call();

    return httpsCallableResult.data["linkId"] ?? "";
  }

  Future<void> deleteLink(
    LinkModel linkModel,
  ) async =>
      await firestore.collection("links").doc(linkModel.uid).delete();
}
