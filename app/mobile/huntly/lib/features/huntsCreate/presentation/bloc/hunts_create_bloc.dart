import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:huntly/core/utils/get_headers.dart';
import 'package:huntly/features/huntsCreate/data/models/clue_model.dart';
import 'package:place_picker/entities/entities.dart';

import '../../../../common/constants.dart';

part 'hunts_create_event.dart';
part 'hunts_create_state.dart';

class HuntsCreateBloc extends Bloc<HuntsCreateEvent, HuntsCreateState> {
  HuntsCreateBloc() : super(HuntsCreateInitial()) {
    on<HuntsCreateEvent>((event, emit) async {
      if (event is CreateHunt) {
        emit(Loading());
        try {
          Dio dio = Dio();

          var params = {
            "name": event.name.toString(),
            "started_at": event.startedAt.toString(),
            "ended_at": event.endedAt.toString(),
            "location_latitude": event.location.latLng!.latitude.toString(),
            "location_longitude": event.location.latLng!.longitude.toString(),
            "location_name": event.location.name.toString(),
            "total_seats": event.total_seats,
            "team_size": event.team_size,
            "theme": event.theme,
          };
          print(jsonEncode(params));
          Response response = await dio.post("${url}treasure-hunts/create/",
              options: await getHeaders(), data: jsonEncode(params));
          print(response.data);
          if (response.statusCode == 201) {
            emit(HuntCreated(
                message: "${response.data["name"]} created",
                id: response.data["id"],
                name: response.data["name"]));
          } else {}
        } catch (e) {
          print("Error in CreateHunt $e");
        }
      } else if (event is AddClues) {
        List<Map<String, dynamic>> clues = [];
        for (var clue in event.clue) {
          clues.add({
            "step_no": clue.stepNo,
            "description": clue.description,
            "answer_description": clue.answerDescription,
            "answer_latitude": clue.answerLatitude,
            "answer_longitude": clue.answerLongitude,
            "is_qr_based": true
          });
        }

        Dio dio = Dio();
        Response response = await dio.post(
          "${url}treasure-hunts/${event.huntId}/clues/create/list/",
          options: await getHeaders(),
          data: jsonEncode(clues),
        );
      }
    });
  }
}
