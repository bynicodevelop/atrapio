class MetadataModel {
  final String title;
  final String image;
  final String description;

  const MetadataModel({
    required this.title,
    required this.image,
    required this.description,
  });

  factory MetadataModel.empty() => const MetadataModel(
        title: "",
        image: "",
        description: "",
      );

  get isEmpty => title.isEmpty && image.isEmpty && description.isEmpty;

  factory MetadataModel.fromJson(Map<String, dynamic> json) => MetadataModel(
        title: json['title'] as String,
        image: json['image'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'description': description,
      };
}
