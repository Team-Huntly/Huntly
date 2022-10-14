import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:huntly/features/hunts/domain/repositories/treasure_hunt_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class UnregisterUser implements UseCase<void, Params> {
  final TreasureHuntRepository repository;

  UnregisterUser(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.unregisterUser(
        treasureHuntId: params.treasureHuntId);
  }
}

class Params extends Equatable {
  final int treasureHuntId;

  const Params({
    required this.treasureHuntId,
  });

  @override
  List<Object> get props => [treasureHuntId];
}
