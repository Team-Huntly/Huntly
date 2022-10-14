part of 'treasurehunt_bloc.dart';

abstract class TreasureHuntEvent extends Equatable {
  const TreasureHuntEvent();

  @override
  List<Object> get props => [];
}

class GetTreasureHunts extends TreasureHuntEvent {}

class RegisterUser extends TreasureHuntEvent {
  final int treasureHuntId;

  const RegisterUser(this.treasureHuntId);
}

class UnregisterUser extends TreasureHuntEvent {
  final int treasureHuntId;

  const UnregisterUser(this.treasureHuntId);
}

class getTeamMates extends TreasureHuntEvent {
  final int treasureHuntId;

  const getTeamMates(this.treasureHuntId);
}
