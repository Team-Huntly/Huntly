import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/core/utils/get_headers.dart';
import 'package:huntly/features/hunts/data/models/leaderboard_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../authentication/data/models/user_model.dart';
import '../models/team_model.dart';
import '../models/treasure_hunt_model.dart';

abstract class TreasureHuntRemoteDataSource {
  Future<List<TreasureHuntModel>> fetchTreasureHunts(
      {required String latitude, required String longitude});

  Future<List<TreasureHuntModel>> fetchRecentTreasureHunts();

  Future<List<TreasureHuntModel>> fetchUserTreasureHunts();

  Future<void> registerUser({required int treasureHuntId});

  Future<void> unregisterUser({required int treasureHuntId});

  Future<TeamModel> getTeammates({required int treasureHuntId});

  Future<LeaderboardModel> getLeaderboard({required int treasureHuntId});

  Future<List<TreasureHuntModel>> getUserHunts();

  Future<UserModel> getUser();
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
        print(response.data);
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
  Future<List<TreasureHuntModel>> fetchUserTreasureHunts() async {
    try {
      Dio dio = Dio();
      var response = await dio.get("${url}users/hunts/upcoming",
          options: await getHeaders());
      print(response.data);
      if (response.statusCode == 200) {
        final List<TreasureHuntModel> treasureHunts = response.data
            .map<TreasureHuntModel>((m) => TreasureHuntModel.fromJson(m))
            .toList();
        return treasureHunts;
      } else {
        throw ServerException();
      }
    } catch (e) {
      // return [];
      debugPrint("error: $e");
      throw NetworkException();
    }
  }

  @override
  Future<List<TreasureHuntModel>> fetchRecentTreasureHunts() async {
    try {
      Dio dio = Dio();
      var response =
          await dio.get("${url}user/hunts/past", options: await getHeaders());
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
  Future<void> registerUser({required int treasureHuntId}) async {
    try {
      Dio dio = Dio();
      var response = await dio.patch(
          "${url}treasure-hunts/$treasureHuntId/register/",
          options: await getHeaders());
      if (response.statusCode == 200) {
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }

  @override
  Future<void> unregisterUser({required int treasureHuntId}) async {
    try {
      Dio dio = Dio();
      var response = await dio.patch(
          "${url}treasure-hunts/$treasureHuntId/unregister/",
          options: await getHeaders());
      if (response.statusCode == 200) {
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }

  @override
  Future<TeamModel> getTeammates({required int treasureHuntId}) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
          "${url}treasure-hunts/$treasureHuntId/my-team/",
          options: await getHeaders());
      if (response.statusCode == 200) {
        return TeamModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }

  @override
  Future<LeaderboardModel> getLeaderboard({required int treasureHuntId}) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
          "${url}treasure-hunts/$treasureHuntId/leaderboard/",
          options: await getHeaders());
      if (response.statusCode == 200) {
        print(response.data);
        return LeaderboardModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }

  @override
  Future<List<TreasureHuntModel>> getUserHunts() async {
    try {
      Dio dio = Dio();
      final response = await dio.get("${url}users/hunts/created/",
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
      debugPrint("herror: $e");
      throw NetworkException();
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      Dio dio = Dio();
      final options = await getHeaders();
      print(options.headers);
      final response =
          await dio.get("${url}users/profile", options: await options);
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        return user;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }
}
