import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class QuerySnapshotMock extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {
  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs =>
      super.noSuchMethod(
        Invocation.getter(#docs),
        returnValue: List<QueryDocumentSnapshot<Map<String, dynamic>>>.from([]),
        returnValueForMissingStub:
            List<QueryDocumentSnapshot<Map<String, dynamic>>>.from([]),
      );
}
