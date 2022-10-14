import 'package:huntly/features/hunts/data/models/theme_model.dart';

import '../../../authentication/data/models/user_model.dart';
import '../../domain/entities/treasure_hunt.dart';

class TreasureHuntModel extends TreasureHunt {
  TreasureHuntModel({
    required int id,
    required String name,
    required DateTime started_at,
    required String ended_at,
    required String location_latitute,
    required String location_longitude,
    required int total_seats,
    required int team_size,
    required ThemeModel theme,
    required bool is_locked,
    required String location_name,
    required List<UserModel> participants,
  }) : super(
          id: id,
          name: name,
          started_at: started_at,
          ended_at: ended_at,
          location_latitute: location_latitute,
          location_longitude: location_longitude,
          total_seats: total_seats,
          team_size: team_size,
          theme: theme,
          is_locked: is_locked,
          location_name: location_name,
          participants: participants,
        );

  factory TreasureHuntModel.fromJson(Map<String, dynamic> json) {
    return TreasureHuntModel(
        id: json['id'],
        name: json['name'],
        started_at: DateTime.parse(json['started_at']),
        ended_at: json['ended_at'],
        location_latitute: json['location_latitute'] ?? "asd",
        location_longitude: json['location_longitude'],
        total_seats: json['total_seats'],
        team_size: json['team_size'],
        is_locked: true,
        location_name: json['location_name'],
        participants: json['participants']
            .map<UserModel>((participant) => UserModel.fromJson(participant))
            .toList(),
        theme: ThemeModel.fromJson(json['theme']));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'started_at': started_at,
      'ended_at': ended_at,
      'location_latitute': location_latitute,
      'location_longitude': location_longitude,
      'total_seats': total_seats,
      'team_size': team_size,
      'theme': theme,
      'is_locked': is_locked,
    };
  }
}
