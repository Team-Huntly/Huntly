import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/core/utils/get_headers.dart';

import '../../../../core/error/exceptions.dart';
import '../models/treasure_hunt_model.dart';

abstract class TreasureHuntRemoteDataSource {
  Future<List<TreasureHuntModel>> fetchTreasureHunts(
      {required String latitude, required String longitude});

  Future<List<TreasureHuntModel>> fetchUserTreasureHunts({required int userId});
}

class TreasureHuntRemoteDataSourceImpl implements TreasureHuntRemoteDataSource {
  @override
  Future<List<TreasureHuntModel>> fetchTreasureHunts(
      {required String latitude, required String longitude}) async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        "${url}treasure-hunts/?latitude=1&longitude=1",
        options: await getHeaders(),
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
      var response = await dio.get("${url}user/treasure-hunts/upcoming",
          options: await getHeaders());
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
