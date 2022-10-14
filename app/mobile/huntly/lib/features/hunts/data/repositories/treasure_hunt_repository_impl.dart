import 'package:dartz/dartz.dart';
import 'package:huntly/features/hunts/domain/entities/treasure_hunt.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/treasure_hunt_repository.dart';
import '../datasources/treasure_hunt_remote_datasource.dart';

class TreasureHuntRepositoryImpl implements TreasureHuntRepository {
  final TreasureHuntRemoteDataSource remoteDataSource;

  TreasureHuntRepositoryImpl({
    required this.remoteDataSource,
  });
  // ArticlesLocalDataSourceImpl localDataSource = ArticlesLocalDataSourceImpl();

  @override
  Future<Either<Failure, List<TreasureHunt>>> fetchTreasureHunts(
      {required String latitude, required String longitude}) async {
    try {
      print("123");
      final treasureHunts = await remoteDataSource.fetchTreasureHunts(
          latitude: latitude, longitude: longitude);
      return Right(treasureHunts);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
