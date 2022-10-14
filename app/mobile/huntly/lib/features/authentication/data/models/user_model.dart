import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required int id,
    required String firstName,
    required String lastName,
    required String email
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    };
  }
}
