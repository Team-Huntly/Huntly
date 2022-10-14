import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  int id;
  String firstName;
  String lastName;
  String email;
  String gender;
  String? dateOfBirth;
  String? phoneNo;
  String? bio;
  String? interests;
  String? profilePic;

  ProfileModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.gender,
      required this.dateOfBirth,
      required this.phoneNo,
      required this.bio,
      required this.interests,
      required this.profilePic});
// from json
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'] ?? 0,
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'],
        gender: json['gender'] ?? '',
        dateOfBirth: json['date_of_birth'] ?? '',
        phoneNo: json['phone_no'] ?? '',
        bio: json['bio'] ?? '',
        interests: json['interests'] ?? '',
        profilePic: json['profile_pic'] ?? '');
  }
  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        gender,
        dateOfBirth ?? '',
        phoneNo ?? '',
        bio ?? '',
        interests ?? '',
        profilePic ?? '',
      ];
}
