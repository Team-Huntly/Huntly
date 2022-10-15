import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:huntly/features/hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import 'package:huntly/features/hunts/data/models/leaderboard_model.dart';
import 'package:huntly/features/hunts/data/repositories/treasure_hunt_repository_impl.dart';

import '../../../../common/constants.dart';
import '../../../../core/utils/get_headers.dart';
import '../../../games/domain/models/game_clue_model.dart';
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
      } else if(event is GetRegisteredTreasureHunts) {
        final _thrs = TreasureHuntRemoteDataSourceImpl();
        List<TreasureHunt> treasureHunts;
        try {
          treasureHunts = await _thrs.fetchUserTreasureHunts();
        }
        catch (e) {
          treasureHunts = [];
        }
        print(treasureHunts);
        emit(Loaded(treasureHunts: treasureHunts));
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
          final TreasureHuntRemoteDataSourceImpl thrds =
              TreasureHuntRemoteDataSourceImpl();
          final TeamModel team =
              await thrds.getTeammates(treasureHuntId: event.treasureHuntId);

          emit(TeamLoaded(teamMates: team));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is GetLeaderboard) {
        emit(Loading());
        try {
          final TreasureHuntRemoteDataSourceImpl thrds =
              TreasureHuntRemoteDataSourceImpl();
          final LeaderboardModel leaderboard =
              await thrds.getLeaderboard(treasureHuntId: event.treasureHuntId);
          emit(LeaderboardLoaded(leaderboard: leaderboard));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is GetRecentTreasureHunts) {
        try {
          emit(Loading());
          final TreasureHuntRemoteDataSourceImpl thrds =
              TreasureHuntRemoteDataSourceImpl();
          final treasureHunts = await thrds.fetchRecentTreasureHunts();
          emit(Loaded(treasureHunts: treasureHunts));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is GetUserHunts) {
        try {
          emit(Loading());
          final TreasureHuntRemoteDataSourceImpl thrds =
              TreasureHuntRemoteDataSourceImpl();
          final treasureHunts = await thrds.getUserHunts();
          emit(Loaded(treasureHunts: treasureHunts));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      } else if (event is GetClues) {
        try {
          emit(Loading());
          print("Loading clues");
          Dio dio = Dio();
          Response response = await dio.get(
              "${url}treasure-hunts/${event.treasureHuntId}/clues/",
              options: await getHeaders());
          print(response.data);
          List<GameClueModel> clues = [];
          for (var clue in response.data) {
            clues.add(GameClueModel.fromJson(clue));
          }
          emit(CluesLoaded(clues: clues));
        } catch (e) {
          debugPrint(e.toString());
          emit(Failed());
        }
      }
    });
  }
}
