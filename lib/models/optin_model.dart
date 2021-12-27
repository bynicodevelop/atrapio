import "package:equatable/equatable.dart";

class OptinModel extends Equatable {
  final String name;
  final String description;

  const OptinModel({
    required this.name,
    required this.description,
  });

  factory OptinModel.fromJson(Map<String, dynamic> json) {
    return OptinModel(
      name: json["name"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
    };
  }

  @override
  List<Object> get props => [
        name,
        description,
      ];
}
