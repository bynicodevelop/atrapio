import 'package:atrap_io/helpers/link_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("LinkHelper", () {
    test("Should return URL with query (nominal case)", () {
      // ARRANGE
      Map<String, dynamic> params = {
        "src": "http://www.exmaple.com",
        "utm_source": "instagram",
        "utm_medium": "stories",
        "utm_campaign": "action",
      };

      final LinkHelper linkHelper = LinkHelper();

      // ACT
      String result = linkHelper.linkFactory(params);

      // ASSERT
      expect(
        result,
        "http://www.exmaple.com?utm_source=instagram&utm_medium=stories&utm_campaign=action",
      );
    });

    test("Should return URL with query space in parameters", () {
      // ARRANGE
      Map<String, dynamic> params = {
        "src": "http://www.exmaple.com",
        "utm_source": "instagram ",
        "utm_medium": "stories ",
        "utm_campaign": "action",
      };

      final LinkHelper linkHelper = LinkHelper();

      // ACT
      String result = linkHelper.linkFactory(params);

      // ASSERT
      expect(
        result,
        "http://www.exmaple.com?utm_source=instagram&utm_medium=stories&utm_campaign=action",
      );
    });

    test("Should return URL without queries", () {
      // ARRANGE
      Map<String, dynamic> params = {
        "src": "http://www.exmaple.com",
      };

      final LinkHelper linkHelper = LinkHelper();

      // ACT
      String result = linkHelper.linkFactory(params);

      // ASSERT
      expect(
        result,
        "http://www.exmaple.com",
      );
    });

    test("Should return URL with empty queries", () {
      // ARRANGE
      Map<String, dynamic> params = {
        "src": "http://www.exmaple.com",
        "utm_source": " ",
        "utm_medium": "",
        "utm_campaign": "action",
      };

      final LinkHelper linkHelper = LinkHelper();

      // ACT
      String result = linkHelper.linkFactory(params);

      // ASSERT
      expect(
        result,
        "http://www.exmaple.com?utm_campaign=action",
      );
    });

    test("Should return URL with empty queries with many space in params", () {
      // ARRANGE
      Map<String, dynamic> params = {
        "src": "http://www.exmaple.com",
        "utm_source": " ",
        "utm_medium": "",
        "utm_campaign": "action with test",
      };

      final LinkHelper linkHelper = LinkHelper();

      // ACT
      String result = linkHelper.linkFactory(params);

      // ASSERT
      expect(
        result,
        "http://www.exmaple.com?utm_campaign=action+with+test",
      );
    });
  });
}
