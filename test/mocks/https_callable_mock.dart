import 'package:cloud_functions/cloud_functions.dart';
import 'package:mockito/mockito.dart';

import 'https_callable_result_mock.dart';

class HttpsCallableMock extends Mock implements HttpsCallable {
  @override
  Future<HttpsCallableResult<T>> call<T>([dynamic parameters]) async =>
      super.noSuchMethod(
        Invocation.method(#call, [parameters]),
        returnValue: HttpsCallableResultMock(),
        returnValueForMissingStub: HttpsCallableResultMock(),
      );
}
