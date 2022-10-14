class RewardModel {
  final String description;
  final String imageLink;
  final String orgName;
  final String url;
  final String code;

  RewardModel({
    required this.description,
    required this.imageLink,
    required this.url,
    required this.code,
    required this.orgName
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      description: json['description']['description'],
      imageLink: json['description']['brand']['logo'] ?? "",
      orgName: json['description']['brand']['name'],
      url: json['url'] ?? "",
      code: json['code']
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
