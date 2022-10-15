class MemoryModel {
  final String huntName;
  final DateTime startedAt;
  final List<String> images;

  MemoryModel({
    required this.startedAt,
    required this.huntName,
    required this.images,
  });

  factory MemoryModel.fromJson(Map<String, dynamic> json) {
    return MemoryModel(
      huntName: json['name'],
      startedAt: DateTime.parse(json['started_at']),
      images: json['memories']
          .map<String>((memory) => memory['image'].toString())
          .toList(),
      // images: json['memories']
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
