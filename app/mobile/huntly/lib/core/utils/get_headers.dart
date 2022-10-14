import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Options> getHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  return Options(
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Token ${prefs.getString("token")}",
    },
  );
}

