import 'package:atrap_io/repositories/upload_repository.dart';
import 'package:mockito/mockito.dart';

class UploadRepositoryMock extends Mock implements UploadRepository {
  @override
  String generateName(String path) => super.noSuchMethod(
        Invocation.method(#generateName, [path]),
        returnValue: "",
        returnValueForMissingStub: "",
      );

  @override
  Future<String> uploadFile(
    String path,
    String fileName,
    String storagePath,
  ) =>
      super.noSuchMethod(
        Invocation.method(#uploadFile, [
          path,
          fileName,
          storagePath,
        ]),
        returnValue: Future.value(""),
        returnValueForMissingStub: Future.value(""),
      );
}
