import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required int id,
      required String firstName,
      required String lastName,
      required String email,
      required String? photoUrl})
      : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            photoUrl: photoUrl);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
        photoUrl: json['profile_pic']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'url': photoUrl
    };
  }
}
