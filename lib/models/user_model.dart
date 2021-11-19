import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;

  const UserModel({
    required this.uid,
    required this.email,
  });

  static const empty = UserModel(
    uid: '',
    email: '',
  );

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
      };

  @override
  List<Object?> get props => [
        uid,
        email,
      ];
}
