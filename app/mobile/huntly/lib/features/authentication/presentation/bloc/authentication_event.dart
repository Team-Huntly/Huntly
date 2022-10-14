part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLogOut extends AuthenticationEvent {}

class AddProfileEvent extends AuthenticationEvent {
  String bio;
  List<Interests> interests;
  AddProfileEvent({required this.bio, required this.interests});

  @override
  List<Object> get props => [bio, interests];
}

class GetProfileEvent extends AuthenticationEvent {}
