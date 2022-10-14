import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:huntly/core/utils/get_headers.dart';
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
          Response response = await dio.post("${url}treasure-hunts/create/",
              options: await getHeaders(), data: jsonEncode(params));
          if (response.statusCode == 201) {
            print(response.data["id"]);
            print(response.data["name"]);
            emit(HuntCreated(message: "${response.data["name"]} created"));
          } else {}
        } catch (e) {
          print("Error in CreateHunt $e");
        }
      }
    });
  }
}
