import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/treasure_hunt.dart';

abstract class TreasureHuntRepository {
  Future<Either<Failure, List<TreasureHunt>>> fetchTreasureHunts({
    required String latitude,
    required String longitude,
  });

  Future<Either<Failure, List<TreasureHunt>>> fetchUserTreasureHunts({
    required int userId,
  });

  Future<Either<Failure, void>> registerUser({
    required int treasureHuntId,
  });

  Future<Either<Failure, void>> unregisterUser({
    required int treasureHuntId,
  });
}
