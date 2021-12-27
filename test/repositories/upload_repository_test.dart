import 'package:atrap_io/repositories/upload_repository.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test for the UploadRepository', () {
    late MockFirebaseStorage storage;

    setUp(() {
      storage = MockFirebaseStorage();
    });

    test('Should return (gs://some-bucketusers/userId/links/linkId/file.png)',
        () async {
      // ARRANGE
      final UploadRepository uploadRepository = UploadRepository(
        storage: storage,
      );

      // ACT
      String url = await uploadRepository.uploadFile(
        "",
        "file.png",
        "users/userId/links/linkId",
      );

      // ASSERT
      expect(url, equals('gs://some-bucketusers/userId/links/linkId/file.png'));
    });
  });
}
