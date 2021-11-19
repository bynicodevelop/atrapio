import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

import 'collection_reference_mock.dart';
import 'document_reference_mock.dart';

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {
  @override
  CollectionReference<Map<String, dynamic>> collection(String collectionPath) =>
      super.noSuchMethod(
        Invocation.method(
          #createUserWithEmailAndPassword,
          [collectionPath],
        ),
        returnValue: CollectionReferenceMock(),
        returnValueForMissingStub: CollectionReferenceMock(),
      );

  @override
  DocumentReference<Map<String, dynamic>> doc(String documentPath) =>
      super.noSuchMethod(
        Invocation.method(
          #doc,
          [documentPath],
        ),
        returnValue: DocumentReferenceMock(),
        returnValueForMissingStub: DocumentReferenceMock(),
      );
}
