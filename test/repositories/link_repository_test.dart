import 'package:atrap_io/exceptions/link_exception.dart';
import 'package:atrap_io/models/link_model.dart';
import 'package:atrap_io/repositories/link_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/collection_reference_mock.dart';
import '../mocks/document_reference_mock.dart';
import '../mocks/firebase_firestore_mock.dart';
import '../mocks/firebase_function_mock.dart';
import '../mocks/https_callable_mock.dart';
import '../mocks/https_callable_result_mock.dart';

void main() {
  group("createLink", () {
    late FirebaseFirestoreMock firestoreMock;

    setUp(() {
      firestoreMock = FirebaseFirestoreMock();
    });

    test("Should create new link with success", () async {
      // ARRANGE
      DocumentReferenceMock userDocumentReference = DocumentReferenceMock();

      CollectionReferenceMock linkCollectionReference =
          CollectionReferenceMock();

      when(userDocumentReference.collection("links"))
          .thenAnswer((_) => linkCollectionReference);

      CollectionReferenceMock userCollectionReference =
          CollectionReferenceMock();

      when(userCollectionReference.doc("user-id"))
          .thenAnswer((_) => userDocumentReference);

      when(firestoreMock.collection("users")).thenAnswer(
        (_) => userCollectionReference,
      );

      DocumentReferenceMock linkDocumentReference = DocumentReferenceMock();

      LinkModel linkModel = LinkModel.fromJson(const {
        "src": "https://www.example.com",
        "linkId": "link-id",
        "userId": "user-id",
        "utm_source": "",
        "utm_medium": "",
        "utm_campaign": "",
        "utm_id": "",
        "utm_term": "",
        "utm_content": "",
        "params": "",
      });

      when(linkDocumentReference.set(linkModel.toJson()))
          .thenAnswer((_) => Future.value());

      when(linkCollectionReference.doc("link-id"))
          .thenAnswer((_) => linkDocumentReference);

      final LinkRepository linkRepository = LinkRepository(
        firestore: firestoreMock,
        functions: FirebaseFunctionsMock(),
      );

      // ACT
      // ASSERT
      expect(
        () async => await linkRepository.createLink({
          "src": "https://www.example.com",
          "linkId": "link-id",
          "userId": "user-id",
          "utm_source": "",
          "utm_medium": "",
          "utm_campaign": "",
          "utm_id": "",
          "utm_term": "",
          "utm_content": "",
          "params": "",
          "created_at": null,
        }),
        returnsNormally,
      );

      verify(await linkDocumentReference.set(linkModel.toJson()));
    });

    test("Should create new link with queries", () async {
      // ARRANGE
      DateTime now = DateTime.now();

      DocumentReferenceMock userDocumentReference = DocumentReferenceMock();

      CollectionReferenceMock linkCollectionReference =
          CollectionReferenceMock();

      when(userDocumentReference.collection("links"))
          .thenAnswer((_) => linkCollectionReference);

      CollectionReferenceMock userCollectionReference =
          CollectionReferenceMock();

      when(userCollectionReference.doc("user-id"))
          .thenAnswer((_) => userDocumentReference);

      when(firestoreMock.collection("users")).thenAnswer(
        (_) => userCollectionReference,
      );

      DocumentReferenceMock linkDocumentReference = DocumentReferenceMock();

      LinkModel linkModel = LinkModel.fromJson(const {
        "src":
            "https://www.example.com?utm_source=instagram&utm_medium=stories&utm_campaign=test",
        "linkId": "link-id",
        "userId": "user-id",
        "utm_source": "instagram",
        "utm_medium": "stories",
        "utm_campaign": "test",
        "utm_id": "",
        "utm_term": "",
        "utm_content": "",
        "params": "",
      });

      when(linkDocumentReference.set(linkModel.toJson()))
          .thenAnswer((_) => Future.value());

      when(linkCollectionReference.doc("link-id"))
          .thenAnswer((_) => linkDocumentReference);

      final LinkRepository linkRepository = LinkRepository(
        firestore: firestoreMock,
        functions: FirebaseFunctionsMock(),
      );

      // ACT
      // ASSERT
      expect(
        () async => await linkRepository.createLink({
          "src": "https://www.example.com",
          "linkId": "link-id",
          "userId": "user-id",
          "utm_source": "instagram",
          "utm_medium": "stories",
          "utm_campaign": "test",
          "utm_id": "",
          "utm_term": "",
          "utm_content": "",
          "params": "",
        }),
        returnsNormally,
      );

      verify(await linkDocumentReference.set(linkModel.toJson()));
    });

    test("Should expect an error when userId is empty", () {
      // ARRANGE
      final LinkRepository linkRepository = LinkRepository(
        firestore: firestoreMock,
        functions: FirebaseFunctionsMock(),
      );

      // ACT
      // ASSERT
      expect(
        () async => await linkRepository.createLink({
          "src": "https://wwww.example.com",
          "linkId": "link-id",
          "userId": "",
        }),
        throwsA(
          predicate(
            (e) =>
                e is LinkException && e.message == LinkException.userIdRequired,
          ),
        ),
      );
    });

    test("Should expect an error when url is empty", () {
      // ARRANGE
      final LinkRepository linkRepository = LinkRepository(
        firestore: firestoreMock,
        functions: FirebaseFunctionsMock(),
      );

      // ACT
      // ASSERT
      expect(
        () async => await linkRepository.createLink({
          "src": "",
          "linkId": "link-id",
          "userId": "user-id",
        }),
        throwsA(
          predicate(
            (e) =>
                e is LinkException && e.message == LinkException.urlIsRequired,
          ),
        ),
      );
    });

    test("Should expect an error when link id is empty", () {
      // ARRANGE
      final LinkRepository linkRepository = LinkRepository(
        firestore: firestoreMock,
        functions: FirebaseFunctionsMock(),
      );

      // ACT
      // ASSERT
      expect(
        () async => await linkRepository.createLink({
          "src": "https://wwww.example.com",
          "linkId": "",
          "userId": "user-id",
        }),
        throwsA(
          predicate(
            (e) =>
                e is LinkException &&
                e.message == LinkException.linkIdIsRequired,
          ),
        ),
      );
    });
  });

  group("getTemporaryLink", () {
    late FirebaseFunctionsMock firebaseFunctionsMock;

    setUp(() {
      firebaseFunctionsMock = FirebaseFunctionsMock();
    });

    test("Should return temporary link", () async {
      // ARRANGE
      HttpsCallableMock httpsCallableMock = HttpsCallableMock();

      HttpsCallableResultMock httpsCallableResultMock =
          HttpsCallableResultMock();

      when(httpsCallableResultMock.data)
          .thenAnswer((_) => {"linkId": "link-id"});

      when(httpsCallableMock.call()).thenAnswer(
        (_) => Future.value(httpsCallableResultMock),
      );

      when(firebaseFunctionsMock.httpsCallable("getTemporaryLink"))
          .thenAnswer((_) => httpsCallableMock);

      when(firebaseFunctionsMock.httpsCallable("generateTemporaryUniqueId"))
          .thenAnswer(
        (_) => httpsCallableMock,
      );

      LinkRepository linkRepository = LinkRepository(
        firestore: FirebaseFirestoreMock(),
        functions: firebaseFunctionsMock,
      );

      // ACT
      final String linkId = await linkRepository.getTemporaryLink();

      // ASSERT
      expect(linkId, "link-id");
    });
  });

  // group("get links", () {
  //   late FirebaseFirestoreMock firestoreMock;

  //   setUp(() {
  //     firestoreMock = FirebaseFirestoreMock();
  //   });

  // test("Should return an empty list of LinkModel from stream", () async {
  //   // ARRANGE
  //   QueryDocumentSnapshotMock queryDocumentSnapshotMock =
  //       QueryDocumentSnapshotMock();

  //   when(queryDocumentSnapshotMock.data()).thenAnswer(
  //     (_) => Map<String, dynamic>.from({
  //       "src": "https://www.example.com",
  //     }),
  //   );

  //   QuerySnapshotMock querySnapshotMock = QuerySnapshotMock();

  //   when(querySnapshotMock.docs).thenReturn(
  //     List.from([
  //       queryDocumentSnapshotMock,
  //     ]),
  //   );

  //   CollectionReferenceMock linkCollectionReferenceMock =
  //       CollectionReferenceMock();

  //   when(linkCollectionReferenceMock.snapshots()).thenAnswer(
  //     (_) => Stream.value(querySnapshotMock),
  //   );

  //   DocumentReferenceMock userDocumentReference = DocumentReferenceMock();

  //   when(userDocumentReference.collection("links"))
  //       .thenAnswer((_) => linkCollectionReferenceMock);

  //   CollectionReferenceMock userCollectionReferenceMock =
  //       CollectionReferenceMock();

  //   when(userCollectionReferenceMock.doc("user-id")).thenAnswer(
  //     (_) => userDocumentReference,
  //   );

  //   when(firestoreMock.collection("users"))
  //       .thenAnswer((_) => userCollectionReferenceMock);

  //   final LinkRepository linkRepository = LinkRepository(
  //     firestore: firestoreMock,
  //     functions: FirebaseFunctionsMock(),
  //   );

  //   // ACT
  //   final Stream<List<LinkModel>> linksStream =
  //       linkRepository.links("user-id");

  //   // ASSERT
  //   expect((await linksStream.first).length, 1);
  // });

  // test("Should return a list of LinkModel from stream", () async {
  //   // ARRANGE
  //   QuerySnapshotMock querySnapshotMock = QuerySnapshotMock();

  //   when(querySnapshotMock.docs).thenReturn(
  //     List.from([]),
  //   );

  //   CollectionReferenceMock linkCollectionReferenceMock =
  //       CollectionReferenceMock();

  //   when(linkCollectionReferenceMock.snapshots()).thenAnswer(
  //     (_) => Stream.value(querySnapshotMock),
  //   );

  //   when(firestoreMock.collection("links"))
  //       .thenAnswer((_) => linkCollectionReferenceMock);

  //   DocumentReferenceMock userDocumentReference = DocumentReferenceMock();

  //   when(userDocumentReference.collection("links"))
  //       .thenAnswer((_) => linkCollectionReferenceMock);

  //   CollectionReferenceMock userCollectionReferenceMock =
  //       CollectionReferenceMock();

  //   when(userCollectionReferenceMock.doc("user-id")).thenAnswer(
  //     (_) => userDocumentReference,
  //   );

  //   when(firestoreMock.collection("users"))
  //       .thenAnswer((_) => userCollectionReferenceMock);

  //   final LinkRepository linkRepository = LinkRepository(
  //     firestore: firestoreMock,
  //     functions: FirebaseFunctionsMock(),
  //   );

  //   // ACT
  //   final Stream<List<LinkModel>> linksStream =
  //       linkRepository.links("user-id");

  //   // ASSERT
  //   expect((await linksStream.first).length, 0);
  // });
  // });

  group("deleteLink", () {
    late FirebaseFirestoreMock firestoreMock;

    setUp(() {
      firestoreMock = FirebaseFirestoreMock();
    });

    test("Should delete link with success", () async {
      // ARRANGE
      DateTime now = DateTime.now();

      DocumentReferenceMock documentReferenceMock = DocumentReferenceMock();

      when(documentReferenceMock.delete()).thenAnswer(
        (_) => Future.value(),
      );

      CollectionReferenceMock linkCollectionReferenceMock =
          CollectionReferenceMock();

      when(linkCollectionReferenceMock.doc("link-id"))
          .thenAnswer((_) => documentReferenceMock);

      when(firestoreMock.collection("links"))
          .thenAnswer((_) => linkCollectionReferenceMock);

      final LinkRepository linkRepository = LinkRepository(
        firestore: firestoreMock,
        functions: FirebaseFunctionsMock(),
      );

      // ACT
      await linkRepository.deleteLink(
        LinkModel.fromJson(const {
          "uid": "link-id",
          "src": "src",
          "created_at": null,
        }),
      );

      // ASSERT
      verify(documentReferenceMock.delete()).called(1);
    });
  });
}
