import 'package:cloud_functions/cloud_functions.dart';
import 'package:mockito/mockito.dart';

class HttpsCallableResultMock extends Mock implements HttpsCallableResult {
  @override
  get data => super.noSuchMethod(
        Invocation.getter(#data),
        returnValue: null,
        returnValueForMissingStub: null,
      );
}
