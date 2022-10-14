import '../../domain/entities/theme.dart';

class ThemeModel extends Theme {
  const ThemeModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory ThemeModel.fromJson(Map<String, dynamic> json) {
    return ThemeModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
