import 'package:equatable/equatable.dart';
import 'package:huntly/features/authentication/data/models/user_model.dart';
import 'package:huntly/features/authentication/domain/entities/user.dart';

import '../../data/models/theme_model.dart';

class TreasureHunt extends Equatable {
  String name;
  DateTime started_at;
  String ended_at;
  String location_latitute;
  String location_longitude;
  int total_seats;
  int team_size;
  ThemeModel theme;
  bool is_locked;
  String location_name;
  List<UserModel> participants;

  TreasureHunt({
    required this.name,
    required this.started_at,
    required this.ended_at,
    required this.location_latitute,
    required this.location_longitude,
    required this.total_seats,
    required this.team_size,
    required this.theme,
    required this.is_locked,
    required this.location_name,
    required this.participants,
  });

  @override
  List<Object> get props => [
        name,
        started_at,
        ended_at,
        location_latitute,
        location_longitude,
        total_seats,
        team_size,
        theme,
        is_locked,
        participants,
        theme
      ];
}
