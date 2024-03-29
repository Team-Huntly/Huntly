part of 'treasurehunt_bloc.dart';

abstract class TreasureHuntEvent extends Equatable {
  const TreasureHuntEvent();

  @override
  List<Object> get props => [];
}

class GetTreasureHunts extends TreasureHuntEvent {}

class GetRegisteredTreasureHunts extends TreasureHuntEvent {}

class RegisterUser extends TreasureHuntEvent {
  final int treasureHuntId;

  const RegisterUser(this.treasureHuntId);
}

class UnregisterUser extends TreasureHuntEvent {
  final int treasureHuntId;

  const UnregisterUser(this.treasureHuntId);
}

class GetTeamMates extends TreasureHuntEvent {
  final int treasureHuntId;

  const GetTeamMates(this.treasureHuntId);
}

class GetUserHunts extends TreasureHuntEvent {}

class GetLeaderboard extends TreasureHuntEvent {
  final int treasureHuntId;

  const GetLeaderboard(this.treasureHuntId);
}

class GetRecentTreasureHunts extends TreasureHuntEvent {}

class GetClues extends TreasureHuntEvent {
  final int treasureHuntId;
  GetClues({required this.treasureHuntId});
}
