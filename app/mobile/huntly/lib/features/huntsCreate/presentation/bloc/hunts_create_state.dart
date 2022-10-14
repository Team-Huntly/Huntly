part of 'hunts_create_bloc.dart';

abstract class HuntsCreateState extends Equatable {
  const HuntsCreateState();

  @override
  List<Object> get props => [];
}

class HuntsCreateInitial extends HuntsCreateState {}

class HuntCreated extends HuntsCreateState {
  final String message;
  final int id;
  final String name;
  HuntCreated({required this.message, required this.id, required this.name});
  @override
  List<Object> get props => [message];
}

class Loading extends HuntsCreateState {}

class AddedClues extends HuntsCreateState {}
