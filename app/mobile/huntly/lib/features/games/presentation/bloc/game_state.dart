part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameStarted extends GameState {}

class TeamLoaded extends GameState {
  final TeamModel team;
  TeamLoaded({required this.team});
}

class CluesLoaded extends GameState {
  List<GameClueModel> clues;
  int index;
  int teamId;
  CluesLoaded({required this.clues, required this.index, required this.teamId});

  @override
  List<Object> get props => [clues];
}

class LocationVerified extends GameState {}

class LocationUnverified extends GameState {}

class ProgressUpdated extends GameState {}

class GameEnded extends GameState {}

class GameError extends GameState {}

class Loading extends GameState {}

class ClueSolved extends GameState {
  List<GameClueModel> clues;
  int index;
  int teamId;
  ClueSolved({required this.clues, required this.index, required this.teamId});
}
