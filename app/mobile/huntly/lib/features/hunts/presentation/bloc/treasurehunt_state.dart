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
  Loaded({required this.treasureHunts});
  @override
  List<Object> get props => [treasureHunts];
}
