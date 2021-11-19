import 'package:cloud_functions/cloud_functions.dart';
import 'package:mockito/mockito.dart';

import 'https_callable_mock.dart';

class FirebaseFunctionsMock extends Mock implements FirebaseFunctions {
  @override
  HttpsCallable httpsCallable(String name, {HttpsCallableOptions? options}) =>
      super.noSuchMethod(
        Invocation.method(#httpCallable, [name, options]),
        returnValue: HttpsCallableMock(),
        returnValueForMissingStub: HttpsCallableMock(),
      );
}
