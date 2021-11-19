import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

// ignore: subtype_of_sealed_class
class QueryDocumentSnapshotMock extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {
  @override
  Map<String, dynamic> data() => super.noSuchMethod(
        Invocation.method(#data, []),
        returnValue: Map<String, dynamic>.from({}),
        returnValueForMissingStub: Map<String, dynamic>.from({}),
      );
}
