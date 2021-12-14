import 'package:atrap_io/models/tracking_id_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class TrackerRepository {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;

  const TrackerRepository({
    required this.firestore,
    required this.functions,
  });

  Future<TrackingIdModel> trackingId(String userId) async {
    QuerySnapshot trackingsId = await firestore
        .collection("users")
        .doc(userId)
        .collection("trackings")
        .get();

    if (trackingsId.size > 0) {
      return TrackingIdModel.fromJson(
        {
          ...trackingsId.docs.first.data() as Map<String, dynamic>,
          ...{"trackingId": trackingsId.docs.first.id}
        },
      );
    }

    return TrackingIdModel.empty();
  }

  Future<TrackingIdModel> generateTrackingId(
    String url,
  ) async {
    try {
      HttpsCallableResult httpsCallableResult =
          await functions.httpsCallable("generateTrackingId").call({
        "url": url.toLowerCase(),
      });

      return TrackingIdModel.fromJson(
        httpsCallableResult.data,
      );
    } catch (e) {
      return TrackingIdModel.empty();
    }
  }
}
