import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:huntly/features/rewards/data/datasources/reward_remote_datasource.dart';

import '../../data/model/reward_model.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc() : super(RewardsInitial()) {
    on<RewardsEvent>((event, emit) async {
      if (event is GetUserRewards) {
        emit(Loading());
        try {
          final RewardRemoteDatasourceImpl rrds = RewardRemoteDatasourceImpl();
          final rewards = await rrds.fetchUserRewards();
          emit(Loaded(rewards: rewards));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      }
    });
  }
}
