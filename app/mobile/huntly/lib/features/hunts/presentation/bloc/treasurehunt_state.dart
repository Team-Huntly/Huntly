part of 'treasurehunt_bloc.dart';

abstract class TreasureHuntState extends Equatable {
  const TreasureHuntState();

  @override
  List<Object> get props => [];
}

class TreasureHuntInitial extends TreasureHuntState {}

class Loading extends TreasureHuntState {}

class Failed extends TreasureHuntState {}

class Loaded extends TreasureHuntState {
  final List<TreasureHunt> treasureHunts;

  const Loaded({required this.treasureHunts});

  @override
  List<Object> get props => [treasureHunts];
}

class RecentHuntsLoaded extends TreasureHuntState {
  final List<TreasureHunt> treasureHunts;

  const RecentHuntsLoaded({required this.treasureHunts});

  @override
  List<Object> get props => [treasureHunts];
}

class Done extends TreasureHuntState {}

class TeamLoaded extends TreasureHuntState {
  final TeamModel teamMates;

  const TeamLoaded({required this.teamMates});

  @override
  List<Object> get props => [teamMates];
}

class LeaderboardLoaded extends TreasureHuntState {
  final LeaderboardModel leaderboard;

  const LeaderboardLoaded({required this.leaderboard});

  @override
  List<Object> get props => [leaderboard];
}

class CluesLoaded extends TreasureHuntState {
  final List<GameClueModel> clues;
  CluesLoaded({required this.clues});

  @override
  List<Object> get props => [clues];
}
