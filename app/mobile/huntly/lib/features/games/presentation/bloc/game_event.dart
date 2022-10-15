part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartGame extends GameEvent {}

class GetClues extends GameEvent {
  int treasureHuntId;
  int teamId;
  GetClues({required this.treasureHuntId, required this.teamId});
}

class VerifyLocation extends GameEvent {}

class UpdateProgress extends GameEvent {}

class SetUpGame extends GameEvent {
  final int treasureHuntId;
  SetUpGame({required this.treasureHuntId});
}

class VerifyClue extends GameEvent {
  final int clueId;
  final int treasureHuntId;
  final int teamId;
  final int index;
  final List<GameClueModel> clues;
  VerifyClue(
      {required this.clueId,
      required this.treasureHuntId,
      required this.clues,
      required this.teamId,
      required this.index});
}

class NextClue extends GameEvent {
  final int index;
  final List<GameClueModel> clues;
  final int teamId;
  NextClue({required this.index, required this.clues, required this.teamId});
}
