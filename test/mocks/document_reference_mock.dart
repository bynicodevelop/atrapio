import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'collection_reference_mock.dart';

// ignore: subtype_of_sealed_class, must_be_immutable
class DocumentReferenceMock extends Mock
    implements DocumentReference<Map<String, dynamic>> {
  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) =>
      super.noSuchMethod(
        Invocation.method(#collection, [collectionPath]),
        returnValue: CollectionReferenceMock(),
        returnValueForMissingStub: CollectionReferenceMock(),
      );

  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) =>
      super.noSuchMethod(
        Invocation.method(#set, [data, options]),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value(),
      );

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots(
          {bool includeMetadataChanges = false}) =>
      super.noSuchMethod(
        Invocation.method(#snapshots, [includeMetadataChanges]),
        returnValue: const Stream.empty(),
        returnValueForMissingStub: const Stream.empty(),
      );

  @override
  Future<void> delete() => super.noSuchMethod(
        Invocation.method(#delete, []),
        returnValue: Future.value(),
        returnValueForMissingStub: Future.value(),
      );
}
