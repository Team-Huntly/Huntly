part of 'hunts_create_bloc.dart';

abstract class HuntsCreateEvent extends Equatable {
  const HuntsCreateEvent();

  @override
  List<Object> get props => [];
}

class CreateHunt extends HuntsCreateEvent {
  final String name;
  final String startedAt;
  final String endedAt;
  final LocationResult location;
  final int total_seats;
  final int team_size;
  final int theme;

  CreateHunt({
    required this.name,
    required this.startedAt,
    required this.endedAt,
    required this.location,
    required this.total_seats,
    required this.team_size,
    required this.theme,
  });
}

class AddClues extends HuntsCreateEvent {
  final int huntId;
  final List<ClueModel> clue;

  AddClues({
    required this.huntId,
    required this.clue,
  });
}
