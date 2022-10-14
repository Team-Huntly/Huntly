part of 'hunts_create_bloc.dart';

abstract class HuntsCreateEvent extends Equatable {
  const HuntsCreateEvent();

  @override
  List<Object> get props => [];
}

class CreateHunt extends HuntsCreateEvent {
  final String title;
  final String description;
  final String location;
  final String date;
  final String time;
  final String duration;
  final String maxParticipants;
  final String minParticipants;
  final String price;
  final String category;
  final String image;
  final String userId;

  CreateHunt({
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.maxParticipants,
    required this.minParticipants,
    required this.price,
    required this.category,
    required this.image,
    required this.userId,
  });
}
