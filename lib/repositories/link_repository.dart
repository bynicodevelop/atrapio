import 'package:atrap_io/exceptions/link_exception.dart';
import 'package:atrap_io/helpers/link_helper.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/repositories/upload_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class LinkRepository {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;
  final UploadRepository uploadRepository;

  const LinkRepository({
    required this.firestore,
    required this.functions,
    required this.uploadRepository,
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
        (QuerySnapshot<Map<String, dynamic>> snapshot) =>
            snapshot.docs.map((doc) {
          return LinkModel.fromJson({
            ...doc.data(),
            ...{
              "name": doc.data()["name"] ?? "",
              "uid": doc.id,
            }
          });
        }).toList(),
      );

  Future<void> createLink(Map<String, dynamic> params) async {
    if (params["userId"].toString().isEmpty) {
      throw LinkException(
        LinkException.userIdRequired,
      );
    }

    if (params["src"].toString().isEmpty) {
      throw LinkException(
        LinkException.urlIsRequired,
      );
    }

    if (params["linkId"].toString().isEmpty) {
      throw LinkException(
        LinkException.linkIdIsRequired,
      );
    }

    final LinkHelper linkHelper = LinkHelper();

    String link = linkHelper.linkFactory(params);

    if (link.isNotEmpty) {
      params["src"] = link;
    }

    String storagePath = "users/${params["userId"]}/links/${params["linkId"]}";

    final String fileName = uploadRepository.generateName(
      params["optin_param_model"]["image"],
    );

    params["optin_param_model"]["image"] = await uploadRepository.uploadFile(
      params["optin_param_model"]["image"],
      fileName,
      storagePath,
    );

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

  Future<void> updateLink(Map<String, dynamic> params) async {
    if (params["userId"].toString().isEmpty) {
      throw LinkException(LinkException.userIdRequired);
    }

    params["created_at"] = Timestamp.fromDate(params["created_at"]);

    LinkModel linkModel = LinkModel.fromJson(params);

    await firestore
        .collection("users")
        .doc(params["userId"])
        .collection("links")
        .doc(params["linkId"])
        .update(
          linkModel.toJson(),
        );
  }

  Future<void> deleteLink(
    LinkModel linkModel,
  ) async =>
      await firestore.collection("links").doc(linkModel.uid).delete();

  Future<LinkModel> getLinkById(Map<String, dynamic> params) async {
    if (params["userId"].toString().isEmpty) {
      throw LinkException(
        LinkException.userIdRequired,
      );
    }

    if (params["linkId"].toString().isEmpty) {
      throw LinkException(
        LinkException.linkIdIsRequired,
      );
    }

    DocumentSnapshot<Map<String, dynamic>> linkDocumentSnapshot =
        await firestore
            .collection("users")
            .doc(params["userId"])
            .collection("links")
            .doc(params["linkId"])
            .get();

    if (!linkDocumentSnapshot.exists) {
      throw LinkException(
        LinkException.invalidLinkId,
      );
    }

    QuerySnapshot<Map<String, dynamic>> clicksPerDays = await firestore
        .doc(linkDocumentSnapshot.get("linkRef"))
        .collection("clicks-by-days")
        .where(
          "timestamp",
          isGreaterThan: DateTime.now()
              .subtract(
                const Duration(
                  days: 1,
                ),
              )
              .millisecondsSinceEpoch,
        )
        .limit(1)
        .get();

    QuerySnapshot<Map<String, dynamic>> clicksPerHours = await firestore
        .doc(linkDocumentSnapshot.get("linkRef"))
        .collection("clicks-by-hours")
        .where(
          "timestamp",
          isGreaterThan: DateTime.now()
              .subtract(
                const Duration(
                  hours: 1,
                ),
              )
              .millisecondsSinceEpoch,
        )
        .limit(1)
        .get();

    return LinkModel.fromJson({
      ...linkDocumentSnapshot.data()!,
      ...{
        "name": linkDocumentSnapshot.data()!["name"] ?? "",
        "uid": linkDocumentSnapshot.id,
        "stats": {
          "clicks_per_days": clicksPerDays.docs.isNotEmpty
              ? clicksPerDays.docs[0].data()["value"]
              : 0,
          "clicks_per_hours": clicksPerHours.docs.isNotEmpty
              ? clicksPerHours.docs[0].data()["value"]
              : 0,
        },
      }
    });
  }
}
