import 'package:read_smart/core/error/exceptions.dart';
import 'package:read_smart/core/error/failures.dart';
import 'package:read_smart/core/network/network_info.dart';
import 'package:read_smart/data/datasources/user_info_local_data_source.dart';
import 'package:read_smart/data/datasources/user_info_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_smart/data/repositories/user_info_repository_impl.dart';
import 'user_info_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, UserInfoLocalDataSource, UserInfoRemoteDataSource])
void main() {
  final userID = '381MFH1HCNAMHGHT0';
  final currentStreak = 5;
  late MockNetworkInfo mockNetworkInfo;
  late MockUserInfoLocalDataSource mockUserInfoLocalDataSource;
  late MockUserInfoRemoteDataSource mockUserInfoRemoteDataSource;
  late UserInfoRepositoryImpl repository;

  setUpAll(() {
    mockNetworkInfo = MockNetworkInfo();
    mockUserInfoRemoteDataSource = MockUserInfoRemoteDataSource();
    mockUserInfoLocalDataSource = MockUserInfoLocalDataSource();
    repository = UserInfoRepositoryImpl(
        remoteDataSource: mockUserInfoRemoteDataSource,
        localDataSource: mockUserInfoLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('Device is connected to the internet', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
        'should return remote data when call to remote data source is sucessfull',
        () async {
      // Arrange
      when(mockUserInfoRemoteDataSource.getUserStreak(userID))
          .thenAnswer((_) async => currentStreak);
      // Act
      final result = await repository.getUserStreak(userID);
      // Assert
      verify(mockUserInfoRemoteDataSource.getUserStreak(userID));
      expect(result, Right(currentStreak));
    });

    test(
        'should cache data locally when call to remote data source is sucessfull',
        () async {
      // Arrange
      when(mockUserInfoRemoteDataSource.getUserStreak(userID))
          .thenAnswer((_) async => currentStreak);
      await repository.getUserStreak(userID);
      verify(mockUserInfoLocalDataSource.cacheUserStreak(currentStreak));
    });

    test(
        'should return ServerFailure when call to remote data source is not sucessfull',
        () async {
      // Arrange
      when(mockUserInfoRemoteDataSource.getUserStreak(userID))
          .thenThrow(ServerException());
      // Act
      final result = await repository.getUserStreak(userID);
      // Assert
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('Device is not connected to the internet', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test(
        'should return cached data when call to local data source is sucessfull',
        () async {
      // Arrange
      when(mockUserInfoLocalDataSource.getStreak())
          .thenAnswer((_) async => currentStreak);
      // Act
      final result = await repository.getUserStreak(userID);
      // Assert
      verify(mockUserInfoLocalDataSource.getStreak());
      expect(result, Right(currentStreak));
    });

    test(
        'should return CacheFailure when call to local data source is not sucessfull',
        () async {
      // Arrange
      when(mockUserInfoLocalDataSource.getStreak()).thenThrow(CacheException());
      // Act
      final result = await repository.getUserStreak(userID);
      // Assert
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
