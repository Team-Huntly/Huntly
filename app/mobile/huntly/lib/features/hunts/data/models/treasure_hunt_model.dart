import 'dart:ffi';

import '../../domain/entities/treasure_hunt.dart';

class TreasureHuntModel extends TreasureHunt {
  TreasureHuntModel({
    required String name,
    required DateTime started_at,
    required String ended_at,
    required String location_latitute,
    required String location_longitude,
    required int total_seats,
    required int team_size,
    required dynamic theme,
    required bool is_locked,
  }) : super(
          name: name,
          started_at: started_at,
          ended_at: ended_at,
          location_latitute: location_latitute,
          location_longitude: location_longitude,
          total_seats: total_seats,
          team_size: team_size,
          theme: theme,
          is_locked: is_locked,
        );

  factory TreasureHuntModel.fromJson(Map<String, dynamic> json) {
    print(json['name']);
    print(json['started_at']);
    print(json['ended_at']);
    print(json['location_latitute']);
    print(json['location_longitude']);
    print(json['total_seats']);
    print(json['team_size']);
    // print(json['theme']);
    return TreasureHuntModel(
      name: json['name'],
      started_at: DateTime.parse(json['started_at']),
      ended_at: json['ended_at'],
      location_latitute: json['location_latitute'] ?? "asd",
      location_longitude: json['location_longitude'],
      total_seats: json['total_seats'],
      team_size: json['team_size'],
      theme: json['theme'],
      is_locked: true,
    );
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
