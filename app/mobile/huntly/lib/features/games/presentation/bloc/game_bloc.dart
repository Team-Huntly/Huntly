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
        final TreasureHuntRemoteDataSourceImpl THRDS =
            TreasureHuntRemoteDataSourceImpl();
        final TeamModel team =
            await THRDS.getTeammates(treasureHuntId: event.treasureHuntId);
        final teamId = team.id;
        final teamName = team.name;
        emit(TeamLoaded(team: team));
      } else if (event is GetClues) {
        Dio dio = Dio();
        Response response = await dio.get(
            "${url}treasure-hunts/${event.treasureHuntId}/clues/",
            options: await getHeaders());
        int _index = 0;
        try {
          Response pResponse = await dio.get(
            "${url}treasure-hunts/teams/${event.teamId}/progress/",
            options: await getHeaders(),
          );
          _index = pResponse.data.length;
        } catch (e) {
          _index = 0;
        }

        List<GameClueModel> clues = [];
        for (var clue in response.data) {
          clues.add(GameClueModel.fromJson(clue));
        }
        if (_index == clues.length) {
          emit(GameEnded());
        } else {
          emit(CluesLoaded(clues: clues, index: _index, teamId: event.teamId));
        }
      } else if (event is VerifyClue) {
        emit(Loading());
        Position position = await determinePosition();
        double latitude = position.latitude;
        double longitude = position.longitude;
        Dio dio = Dio();
        var params = {
          "latitude": latitude,
          "longitude": longitude,
          "clue": event.clueId
        };
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
        if (response.statusCode == 201) {
          emit(LocationVerified());

          emit(ClueSolved(
              clues: event.clues, index: event.index, teamId: event.teamId));

          Future.delayed(const Duration(seconds: 1), () {});

          if (response.data['clue']['step_no'].toInt() == event.clues.length) {
            emit(GameEnded());
          }
        } else if (response.statusCode == 400) {
          emit(LocationUnverified());
          emit(CluesLoaded(
              clues: event.clues, index: event.index, teamId: event.teamId));
        }
        else if (response.statusCode == 409) {
          emit(CluesLoaded(
            clues: event.clues, index: event.index + 1, teamId: event.teamId));  
        }
      } else if (event is NextClue) {
        emit(CluesLoaded(
            clues: event.clues, index: event.index + 1, teamId: event.teamId));
      }
    });
  }
}
