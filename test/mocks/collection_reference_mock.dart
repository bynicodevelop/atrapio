import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'document_reference_mock.dart';

// ignore: subtype_of_sealed_class, must_be_immutable
class CollectionReferenceMock extends Mock
    implements CollectionReference<Map<String, dynamic>> {
  @override
  DocumentReference<Map<String, dynamic>> doc([String? path]) =>
      super.noSuchMethod(
        Invocation.method(#doc, [path]),
        returnValue: DocumentReferenceMock(),
        returnValueForMissingStub: DocumentReferenceMock(),
      );

  Future<DocumentReference<Map<String, dynamic>>> set(
          Map<String, dynamic> data) =>
      super.noSuchMethod(
        Invocation.method(#set, [data]),
        returnValue: Future.value(DocumentReferenceMock()),
        returnValueForMissingStub: Future.value(DocumentReferenceMock()),
      );
}
