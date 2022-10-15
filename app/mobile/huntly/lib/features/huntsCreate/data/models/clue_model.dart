class ClueModel {
  final int stepNo;
  final String description;
  final String answerDescription;
  final String answerLatitude;
  final String answerLongitude;
  final bool isQrBased;

  const ClueModel({
    required this.stepNo,
    required this.description,
    required this.answerDescription,
    required this.answerLatitude,
    required this.answerLongitude,
    required this.isQrBased,
  });

  factory ClueModel.fromJson(Map<String, dynamic> json) {
    return ClueModel(
      stepNo: json['step_no'],
      description: json['description'],
      answerDescription: json['answer_description'],
      answerLatitude: json['answer_latitude'],
      answerLongitude: json['answer_longitude'],
      isQrBased: json['is_qr_based'],
    );
  }
}
