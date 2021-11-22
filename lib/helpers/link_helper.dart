class LinkHelper {
  String linkFactory(Map<String, dynamic> params) {
    List<String> utms = [
      "utm_source",
      "utm_medium",
      "utm_campaign",
      "utm_id",
      "utm_term",
      "utm_content",
      "params"
    ];

    String queries = params.entries
        .where(
          (entry) =>
              utms.contains(entry.key) &&
              entry.value.toString().trim().isNotEmpty,
        )
        .map((entry) =>
            "${entry.key}=${entry.value.toString().trim().replaceAll(" ", "+")}")
        .toList()
        .join("&");

    return Uri.encodeFull(
      queries.isNotEmpty ? "${params["src"]}?$queries" : params["src"],
    );
  }
}
