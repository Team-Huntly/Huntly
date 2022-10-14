import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/core/utils/get_headers.dart';
import 'package:huntly/features/rewards/data/model/reward_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class RewardRemoteDatasource {
  Future<List<RewardModel>> fetchUserRewards();
}

class RewardRemoteDatasourceImpl implements RewardRemoteDatasource {
  @override
  Future<List<RewardModel>> fetchUserRewards() async {
    try {
      print("------");
      Dio dio = Dio();
      final response = await dio.get(
        "${url}users/rewards",
        options: await getHeaders(),
      );
      print("Here");
      print(response);
      if (response.statusCode == 200) {
        List<RewardModel> rewards = response.data
            .map<RewardModel>((reward) => RewardModel.fromJson(reward))
            .toList();
        return rewards;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }
}
