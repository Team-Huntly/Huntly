import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/treasure_hunt_model.dart';

abstract class TreasureHuntRemoteDataSource {
  Future<List<TreasureHuntModel>> fetchTreasureHunts(
      {required String latitude, required String longitude});

  Future<List<TreasureHuntModel>> fetchUserTreasureHunts(
      {required int userId});
  
}

class TreasureHuntRemoteDataSourceImpl implements TreasureHuntRemoteDataSource {
  @override
  Future<List<TreasureHuntModel>> fetchTreasureHunts(
      {required String latitude, required String longitude}) async {
    try {
      print("1234");
      // !! Todo : Add current position
      // Position _currentPosition = await determinePosition();
      Dio dio = Dio();
      final _prefs = await SharedPreferences.getInstance();
      print(_prefs.getString("token"));
      var response = await dio.get(
        "${url}treasure-hunts/?latitude=1&longitude=1",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Token ${_prefs.getString("token")}",
          },
        ),
      );
      if (response.statusCode == 200) {
        List<TreasureHuntModel> treasureHunts = response.data
            .map<TreasureHuntModel>((m) => TreasureHuntModel.fromJson(m))
            .toList();
        return treasureHunts;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }

  @override
  Future<List<TreasureHuntModel>> fetchUserTreasureHunts(
      {required int userId}) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        "${url}treasure-hunts/?latitude=1&longitude=1",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Token 6b4a27a545d3a191eaca78e85bcef6703f65aff3"
          },
        ),
      );
      if (response.statusCode == 200) {
        List<TreasureHuntModel> treasureHunts = response.data
            .map<TreasureHuntModel>((m) => TreasureHuntModel.fromJson(m))
            .toList();
        return treasureHunts;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }
}
