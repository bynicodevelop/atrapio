import 'dart:async';

import 'package:chaleno/chaleno.dart';

class WebScrapperHelper {
  final String src;

  const WebScrapperHelper({
    required this.src,
  });

  Future<Map<String, String>> extractMeta() async {
    Completer<Map<String, String>> completer = Completer();

    Chaleno().load(src).then((value) {
      List<String> images = value!
          .getElementsByTagName("meta")!
          .where((result) => result.attr("property") == "og:image")
          .map((Result e) => e.attr("content").toString())
          .toList();

      List<String> description = value
          .getElementsByTagName("meta")!
          .where((result) => result.attr("name") == "description")
          .map((Result e) => e.attr("content").toString())
          .toList();

      return completer.complete({
        "title": value.title() ?? "",
        "description": description.isNotEmpty ? description.first : "",
        "image": images.isNotEmpty ? images.first : "",
      });
    }).catchError((onError) {
      return completer.completeError(onError);
    });

    return completer.future;
  }
}
