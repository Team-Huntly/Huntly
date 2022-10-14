part of 'treasurehunt_bloc.dart';

abstract class TreasureHuntEvent extends Equatable {
  const TreasureHuntEvent();

  @override
  List<Object> get props => [];
}

class GetTreasureHunts extends TreasureHuntEvent {}
