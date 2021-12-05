import 'dart:async';

import 'package:atrap_io/exceptions/link_exception.dart';
import 'package:atrap_io/exceptions/link_not_found_exception.dart';
import 'package:atrap_io/helpers/link_helper.dart';
import 'package:atrap_io/helpers/web_scraper_helper.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/models/metadata_model.dart';
import 'package:atrap_io/models/visit_model.dart';
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
      .asyncMap(
        (snapshot) => Future.wait(
          snapshot.docs.map((doc) async {
            DocumentReference documentReference =
                firestore.doc(doc.get("linkRef"));

            QuerySnapshot querySnapshot =
                await documentReference.collection("visits").get();

            List<VisitModel> visits = querySnapshot.docs
                .map(
                  (visit) => VisitModel.fromJson({
                    ...visit.data() as Map<String, dynamic>,
                    ...{"uid": visit.id}
                  }),
                )
                .toList();

            return LinkModel.fromJson({
              ...doc.data(),
              ...{
                "uid": doc.id,
                "visits": visits,
              }
            });
          }).toList(),
        ),
      );

  Future<void> createLink(Map<String, dynamic> params) async {
    if (params["userId"].toString().isEmpty) {
      throw const LinkException(LinkException.userIdRequired);
    }

    if (params["src"].toString().isEmpty) {
      throw const LinkException(LinkException.urlIsRequired);
    }

    if (params["linkId"].toString().isEmpty) {
      throw const LinkException(LinkException.linkIdIsRequired);
    }

    final LinkHelper linkHelper = LinkHelper();

    String link = linkHelper.linkFactory(params);

    if (link.isNotEmpty) {
      params["src"] = link;
    }

    /**
     * Enrichment metadata from utms
     */
    if (params["utm_source"].toString().isNotEmpty &&
        params["utm_campaign"].toString().isNotEmpty &&
        params["utm_source"] == "youtube") {
      String youtubeUrl = "https://youtu.be/${params["utm_campaign"]}";

      WebScrapperHelper webScrapperHelper = WebScrapperHelper(
        src: youtubeUrl,
      );

      Map<String, String> metadata = await webScrapperHelper.extractMeta();

      params["metadata"] = metadata;
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

  Future<LinkModel> getLinkByUid(String uid, String userId) async {
    DocumentSnapshot documentSnapshot = await firestore
        .collection("users")
        .doc(userId)
        .collection("links")
        .doc(uid)
        .get();

    if (!documentSnapshot.exists) {
      throw const LinkNotFoundException();
    }

    DocumentReference documentReference =
        firestore.doc(documentSnapshot.get("linkRef"));

    QuerySnapshot querySnapshot =
        await documentReference.collection("visits").get();

    List<VisitModel> visits = querySnapshot.docs
        .map(
          (visit) => VisitModel.fromJson({
            ...visit.data() as Map<String, dynamic>,
            ...{"uid": visit.id}
          }),
        )
        .toList();

    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    MetadataModel metadataModel = MetadataModel.empty();

    if (data["metadata"] != null) {
      metadataModel = MetadataModel.fromJson(data["metadata"]);
    } else {
      if (data["utm_source"].toString().isNotEmpty &&
          data["utm_campaign"].toString().isNotEmpty &&
          data["utm_source"] == "youtube") {
        String youtubeUrl = "https://youtu.be/${data["utm_campaign"]}";

        WebScrapperHelper webScrapperHelper = WebScrapperHelper(
          src: youtubeUrl,
        );

        Map<String, String> metadata = await webScrapperHelper.extractMeta();

        metadataModel = MetadataModel.fromJson(metadata);

        await _updateMetadata(
          documentSnapshot.reference,
          metadataModel.toJson(),
        );
      }
    }

    return LinkModel.fromJson({
      ...documentSnapshot.data() as Map<String, dynamic>,
      ...{
        "uid": documentSnapshot.id,
        "visits": visits,
        "metadata": metadataModel.toJson(),
      }
    });
  }

  Future<void> _updateMetadata(
    DocumentReference documentReference,
    Map<String, dynamic> metadata,
  ) async {
    await documentReference.update({
      "metadata": metadata,
    });
  }
}
