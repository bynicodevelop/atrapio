import 'dart:async';

import 'package:chaleno/chaleno.dart';

class WebScrapperHelper {
  final String src;

  const WebScrapperHelper({
    required this.src,
  });

  Future<Map<String, String>> extractMeta() async {
    Completer<Map<String, String>> completer = Completer();

    Chaleno().load(src).then(
          (value) => completer.complete({
            "title": value!.title() ?? "",
            "description": value
                .getElementsByTagName("meta")!
                .where((result) => result.attr("name") == "description")
                .map((Result e) => e.attr("content").toString())
                .toList()
                .first,
            "image": value
                .getElementsByTagName("meta")!
                .where((result) => result.attr("property") == "og:image")
                .map((Result e) => e.attr("content").toString())
                .toList()
                .first,
          }),
        );

    return completer.future;
  }
}
