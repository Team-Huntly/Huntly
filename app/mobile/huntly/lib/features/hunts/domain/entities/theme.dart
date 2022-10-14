import 'package:equatable/equatable.dart';
import 'package:huntly/features/authentication/data/models/user_model.dart';
import 'package:huntly/features/authentication/domain/entities/user.dart';

class Theme extends Equatable {
  final int id;
  final String name;

  const Theme({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
