import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:huntly/common/constants.dart';
import 'package:huntly/core/utils/get_headers.dart';

import '../../../../core/error/exceptions.dart';
import '../models/memory_model.dart';

abstract class MemoriesRemoteDatasource {
  Future<List<MemoryModel>> fetchUserMemories();
}

class MemoriesRemoteDatasourceImpl implements MemoriesRemoteDatasource {
  @override
  Future<List<MemoryModel>> fetchUserMemories() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        "${url}users/memories",
        options: await getHeaders(),
      );
      if (response.statusCode == 200) {
        debugPrint(response.data.toString());
        List<MemoryModel> memories = response.data
            .map<MemoryModel>((memory) => MemoryModel.fromJson(memory))
            .toList();
        return memories;
      } else {
        throw ServerException();
      }
    } catch (e) {
      debugPrint("error: $e");
      throw NetworkException();
    }
  }
}
