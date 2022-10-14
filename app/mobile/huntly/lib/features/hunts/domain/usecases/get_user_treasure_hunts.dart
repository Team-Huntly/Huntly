import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:huntly/features/hunts/domain/repositories/treasure_hunt_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/treasure_hunt.dart';

class FetchUserTreasureHunt implements UseCase<List<TreasureHunt>, Params> {
  final TreasureHuntRepository repository;

  FetchUserTreasureHunt(this.repository);

  @override
  Future<Either<Failure, List<TreasureHunt>>> call(Params params) async {
    return await repository.fetchUserTreasureHunts(userId: params.userId);
  }
}

class Params extends Equatable {
  final int userId;

  const Params({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
