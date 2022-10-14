part of 'rewards_bloc.dart';

abstract class RewardsState extends Equatable {
  const RewardsState();

  @override
  List<Object> get props => [];
}

class RewardsInitial extends RewardsState {}

class Loading extends RewardsState {}

class Failed extends RewardsState {}

class Loaded extends RewardsState {
  final List<RewardModel> rewards;
  
  const Loaded({required this.rewards});
  
  @override
  List<Object> get props => [rewards];
}
