import 'package:dartz/dartz.dart';
import 'package:read_smart/core/error/exceptions.dart';

import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/user_info_repository.dart';
import '../datasources/user_info_local_data_source.dart';
import '../datasources/user_info_remote_data_source.dart';

class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoLocalDataSource localDataSource;
  final UserInfoRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  UserInfoRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, int>> getUserStreak(String userID) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final streak = await remoteDataSource.getUserStreak(userID);
        localDataSource.cacheUserStreak(streak);
        return Right(streak);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final streak = await localDataSource.getStreak();
        return Right(streak);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
