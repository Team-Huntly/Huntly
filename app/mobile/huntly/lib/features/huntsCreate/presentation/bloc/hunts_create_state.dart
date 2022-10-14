part of 'hunts_create_bloc.dart';

abstract class HuntsCreateState extends Equatable {
  const HuntsCreateState();

  @override
  List<Object> get props => [];
}

class HuntsCreateInitial extends HuntsCreateState {}

class HuntCreated extends HuntsCreateState {
  final String message;
  HuntCreated({required this.message});
  @override
  List<Object> get props => [message];
}

class Loading extends HuntsCreateState {}
