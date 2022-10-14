part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameStarted extends GameState {}

class ClueLoaded extends GameState {}

class LocationVerified extends GameState {}

class ProgressUpdated extends GameState {}

class GameEnded extends GameState {}

class GameError extends GameState {}
