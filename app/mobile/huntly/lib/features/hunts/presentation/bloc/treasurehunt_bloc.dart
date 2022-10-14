import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:huntly/features/hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import 'package:huntly/features/hunts/data/repositories/treasure_hunt_repository_impl.dart';
import '../../../../core/utils/get_current_location.dart';

import '../../data/models/team_model.dart';
import '../../domain/entities/treasure_hunt.dart';

import '../../domain/usecases/get_treasure_hunts.dart' as gth;
import '../../domain/usecases/register_user.dart' as ru;
import '../../domain/usecases/unregister_user.dart' as uu;

part 'treasurehunt_event.dart';
part 'treasurehunt_state.dart';

class TreasureHuntBloc extends Bloc<TreasureHuntEvent, TreasureHuntState> {
  TreasureHuntBloc() : super(TreasureHuntInitial()) {
    on<TreasureHuntEvent>((event, emit) async {
      if (event is GetTreasureHunts) {
        emit(Loading());

        try {
          final failureOrTreasureHunts = await gth.FetchTreasureHunt(
                  TreasureHuntRepositoryImpl(
                      remoteDataSource: TreasureHuntRemoteDataSourceImpl()))
              .call(const gth.Params(
            latitude: "11212",
            longitude: "2323232",
          ));

          failureOrTreasureHunts.fold((failure) => emit(Failed()),
              (treasureHunts) {
            emit(Loaded(treasureHunts: treasureHunts));
          });
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is RegisterUser) {
        emit(Loading());
        try {
          final failureOrVoid = await ru.RegisterUser(
                  TreasureHuntRepositoryImpl(
                      remoteDataSource: TreasureHuntRemoteDataSourceImpl()))
              .call(ru.Params(treasureHuntId: event.treasureHuntId));
          failureOrVoid.fold((failure) => emit(Failed()), (treasureHunts) {
            emit(Done());
          });
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is UnregisterUser) {
        emit(Loading());
        try {
          final failureOrVoid = await uu.UnregisterUser(
                  TreasureHuntRepositoryImpl(
                      remoteDataSource: TreasureHuntRemoteDataSourceImpl()))
              .call(uu.Params(treasureHuntId: event.treasureHuntId));
          failureOrVoid.fold((failure) => emit(Failed()), (treasureHunts) {
            emit(Done());
          });
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is GetTeamMates) {
        emit(Loading());
        try {
          final TreasureHuntRemoteDataSourceImpl THRDS =
              TreasureHuntRemoteDataSourceImpl();
          final TeamModel team =
              await THRDS.getTeammates(treasureHuntId: event.treasureHuntId);
          print(team);

          emit(TeamLoaded(teamMates: team));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is GetTeamMates) {
        emit(Loading());
        try {
          final TreasureHuntRemoteDataSourceImpl THRDS =
              TreasureHuntRemoteDataSourceImpl();
          final TeamModel team =
              await THRDS.getTeammates(treasureHuntId: event.treasureHuntId);
          print(team);

          emit(TeamLoaded(teamMates: team));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      }
    });
  }
}
