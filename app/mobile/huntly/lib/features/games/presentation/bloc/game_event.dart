part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartGame extends GameEvent {}

class GetClue extends GameEvent {}

class VerifyLocation extends GameEvent {}

class UpdateProgress extends GameEvent {}
