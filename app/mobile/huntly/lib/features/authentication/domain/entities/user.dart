import 'package:equatable/equatable.dart';

abstract class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? photoUrl;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photoUrl,
  });

  @override
  List<Object> get props => [id, firstName, lastName, email];
}
