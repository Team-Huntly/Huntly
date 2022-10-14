import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:huntly/features/hunts/domain/repositories/treasure_hunt_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/treasure_hunt.dart';

class FetchTreasureHunt implements UseCase<List<TreasureHunt>, Params> {
  final TreasureHuntRepository repository;

  FetchTreasureHunt(this.repository);

  @override
  Future<Either<Failure, List<TreasureHunt>>> call(Params params) async {
    return await repository.fetchTreasureHunts(
      latitude: params.latitude,
      longitude: params.longitude,
    );
  }
}

class Params extends Equatable {
  final String latitude;
  final String longitude;

  const Params({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
      ];
}
