import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/features/authentication/data/profile_model.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> fetchProfile();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  @override
  Future<ProfileModel> fetchProfile() async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      Response response = await Dio().get(
        "${url}users/profile/",
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Token ${_prefs.getString("token")}"
          },
        ),
      );

      print("Response => ${response.data}");
      if (response.statusCode == 200) {
        ProfileModel profile = ProfileModel.fromJson(response.data);
        return profile;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }
}
