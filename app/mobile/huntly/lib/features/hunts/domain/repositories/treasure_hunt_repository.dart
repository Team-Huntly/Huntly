import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/treasure_hunt.dart';

abstract class TreasureHuntRepository {
  Future<Either<Failure, List<TreasureHunt>>> fetchTreasureHunts({
    required String latitude,
    required String longitude,
  });
}
