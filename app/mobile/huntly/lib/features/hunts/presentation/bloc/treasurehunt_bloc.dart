import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:huntly/features/hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import 'package:huntly/features/hunts/data/repositories/treasure_hunt_repository_impl.dart';
import '../../../../core/utils/get_current_location.dart';

import '../../domain/entities/treasure_hunt.dart';

import '../../domain/usecases/get_treasure_hunts.dart' as gth;

part 'treasurehunt_event.dart';
part 'treasurehunt_state.dart';

class TreasureHuntBloc extends Bloc<TreasureHuntEvent, TreasureHuntState> {
  TreasureHuntBloc() : super(TreasureHuntInitial()) {
    on<TreasureHuntEvent>((event, emit) async {
      if (event is GetTreasureHunts) {
        emit(Loading());

        try {
          // print("==========================");
          // final Position currentPosition = await determinePosition();
          // print("location: $currentPosition");
          final failureOrTreasureHunts = await gth.FetchTreasureHunt(
                  TreasureHuntRepositoryImpl(
                      remoteDataSource: TreasureHuntRemoteDataSourceImpl()))
              .call(gth.Params(
                latitude: "11212",
                longitude: "2323232",
              )
            );

          failureOrTreasureHunts.fold((failure) => emit(Failed()),
              (treasureHunts) {
            emit(Loaded(treasureHunts: treasureHunts));
          });
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      }
    });
  }
}
