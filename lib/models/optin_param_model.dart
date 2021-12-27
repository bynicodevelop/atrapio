import 'package:equatable/equatable.dart';

class OptinParamModel extends Equatable {
  final String name;
  final String content;
  final String labelButton;
  final String image;

  const OptinParamModel({
    required this.name,
    required this.content,
    required this.labelButton,
    required this.image,
  });

  factory OptinParamModel.fromJson(Map<String, dynamic> json) {
    return OptinParamModel(
      name: json['name'],
      content: json['content'],
      labelButton: json['labelButton'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'content': content,
      'labelButton': labelButton,
      'image': image,
    };
  }

  @override
  List<Object> get props => [
        name,
        content,
        labelButton,
        image,
      ];
}
