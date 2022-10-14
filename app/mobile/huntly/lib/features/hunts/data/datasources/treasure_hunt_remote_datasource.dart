import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:huntly/common/constants.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/treasure_hunt_model.dart';
import '../../../../common/getLocation.dart';
import 'package:geolocator/geolocator.dart';

abstract class TreasureHuntRemoteDataSource {
  Future<List<TreasureHuntModel>> fetchTreasureHunts(
      {required String latitude, required String longitude});
}

class TreasureHuntRemoteDataSourceImpl implements TreasureHuntRemoteDataSource {
  // Just for reference
  // @override
  // Future<List<ArticleModel>> fetchCategoryArticles({
  //   required int page,
  //   required int categoryId,
  //   required bool refreshStatus,
  // }) async {
  //   try {
  //     Dio dio = Dio();
  //     dio.interceptors.add(

  //     if (response.statusCode == 200) {
  //       articles = response.data
  //           .map<ArticleModel>((m) => ArticleModel.fromJson(m))
  //           .toList();

  //       return articles;
  //     } else {
  //       throw ServerException();
  //     }
  //   } catch (e) {
  //     debugPrint("error: $e");
  //     throw NetworkException();
  //   }
  // }

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
      print("12345");
      print(response.data);

      if (response.statusCode == 200) {
        print("As");

        List<TreasureHuntModel> treasureHunts = response.data
            .map<TreasureHuntModel>((m) => TreasureHuntModel.fromJson(m))
            .toList();
        print("As");
        return treasureHunts;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print("error: $e");
      throw NetworkException();
    }
  }
}
