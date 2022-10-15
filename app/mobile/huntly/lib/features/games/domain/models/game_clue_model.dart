import 'package:huntly/features/huntsCreate/data/models/clue_model.dart';

class GameClueModel {
  final int id;
  final int stepNo;
  final String description;
  final String answerDescription;
  final String answerLatitude;
  final String answerLongitude;
  final bool isQrBased;

  GameClueModel({
    required this.id,
    required this.stepNo,
    required this.description,
    required this.answerDescription,
    required this.answerLatitude,
    required this.answerLongitude,
    required this.isQrBased,
  });

  factory GameClueModel.fromJson(Map<String, dynamic> json) {
    return GameClueModel(
      id: json['id'],
      stepNo: json['step_no'],
      description: json['description'],
      answerDescription: json['answer_description'],
      answerLatitude: json['answer_latitude'],
      answerLongitude: json['answer_longitude'],
      isQrBased: json['is_qr_based'],
    );
  }
}
