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

  @override
  Future<Either<Failure, List<TreasureHunt>>> fetchTreasureHunts(
      {required String latitude, required String longitude}) async {
    try {
      final treasureHunts = await remoteDataSource.fetchTreasureHunts(
          latitude: latitude, longitude: longitude);
      return Right(treasureHunts);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<TreasureHunt>>> fetchUserTreasureHunts(
      {required int userId}) async {
    try {
      final treasureHunts = await remoteDataSource.fetchUserTreasureHunts();
      return Right(treasureHunts);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(
      {required int treasureHuntId}) async {
    try {
      final response =
          await remoteDataSource.registerUser(treasureHuntId: treasureHuntId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unregisterUser(
      {required int treasureHuntId}) async {
    try {
      final response =
          await remoteDataSource.unregisterUser(treasureHuntId: treasureHuntId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
