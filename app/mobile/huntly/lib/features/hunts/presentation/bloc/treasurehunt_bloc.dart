import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:huntly/features/hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import 'package:huntly/features/hunts/data/repositories/treasure_hunt_repository_impl.dart';
import 'package:huntly/features/hunts/domain/repositories/treasure_hunt_repository.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/treasure_hunt_model.dart';
import '../../domain/entities/treasure_hunt.dart';

import '../../domain/usecases/get_treasure_hunts.dart' as thd;

part 'treasurehunt_event.dart';
part 'treasurehunt_state.dart';

class TreasureHuntBloc extends Bloc<TreasureHuntEvent, TreasureHuntState> {
  TreasureHuntBloc() : super(TreasureHuntInitial()) {
    on<TreasureHuntEvent>((event, emit) async {
      if (event is GetTreasureHunts) {
        print("hi");
        emit(Loading());

        try {
          final failureOrTreasureHunts = await thd.FetchTreasureHunt(
                  TreasureHuntRepositoryImpl(
                      remoteDataSource: TreasureHuntRemoteDataSourceImpl()))
              .call(thd.Params(
            latitude: "11212",
            longitude: "2323232",
          ));

          failureOrTreasureHunts.fold((failure) => emit(Failed()),
              (treasureHunts) {
            print(treasureHunts);
            emit(Loaded(treasureHunts: treasureHunts));
          });
        } catch (e) {
          print(e);
          emit(Failed());
        }
      }
    });
  }
}
