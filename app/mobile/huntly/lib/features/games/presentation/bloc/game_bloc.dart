import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:huntly/core/utils/get_headers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants.dart';
import '../../../../common/getLocation.dart';
import '../../../hunts/data/datasources/treasure_hunt_remote_datasource.dart';
import '../../../hunts/data/models/team_model.dart';
import '../../domain/models/game_clue_model.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameInitial()) {
    on<GameEvent>((event, emit) async {
      if (event is SetUpGame) {
        print('SETUP GAME');
        final TreasureHuntRemoteDataSourceImpl THRDS =
            TreasureHuntRemoteDataSourceImpl();
        final TeamModel team =
            await THRDS.getTeammates(treasureHuntId: event.treasureHuntId);
        final teamId = team.id;
        final teamName = team.name;
        emit(TeamLoaded(team: team));
        print("Teams loaded");
      } else if (event is GetClues) {
        print("Loading clues");
        Dio dio = Dio();
        Response response = await dio.get(
            "${url}/treasure-hunts/${event.treasureHuntId}/clues/",
            options: await getHeaders());
        print(response.data);
        List<GameClueModel> clues = [];
        for (var clue in response.data) {
          clues.add(GameClueModel.fromJson(clue));
        }
        emit(CluesLoaded(clues: clues, index: 0, teamId: event.teamId));
      } else if (event is VerifyClue) {
        print("Verifying clue");
        Position pos = await determinePosition();
        Dio dio = Dio();
        var params = {"latitude": 1, "longitude": 1, "clue": event.clueId};
        print("${url}/treasure-hunts/teams/${event.teamId}/progress/create/");
        print(jsonEncode(params));
        final prefs = await SharedPreferences.getInstance();
        Response response = await dio.post(
            "${url}treasure-hunts/teams/${event.teamId}/progress/create/",
            data: jsonEncode(params),
            options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Token ${prefs.getString("token")}",
              },
            ));
        print(response.data);
        print(response.statusCode);
        if (response.statusCode == 201) {
          emit(LocationVerified());
          if (response.data["clue"]["id"] == event.clues.length) {
            emit(GameEnded());
          }
          Future.delayed(Duration(seconds: 1), () {});
          emit(CluesLoaded(
              clues: event.clues,
              index: event.index + 1,
              teamId: event.teamId));
        } else if (response.statusCode == 400) {
          print("Unverified");
          emit(LocationUnverified());
          emit(CluesLoaded(
              clues: event.clues, index: event.index, teamId: event.teamId));
        }
      }
    });
  }
}
