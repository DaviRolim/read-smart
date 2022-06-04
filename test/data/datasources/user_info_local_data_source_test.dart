import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:read_smart/core/error/exceptions.dart';
import 'package:read_smart/data/datasources/user_info_local_data_source.dart';
import 'package:read_smart/data/repositories/user_info_repository_impl.dart';

import 'user_info_local_data_source_test.mocks.dart';

@GenerateMocks([HiveInterface, Box])
void main() {
  late MockHiveInterface mockHiveInterface;
  late MockBox mockBox;
  late UserInfoLocalDataSource datasource;
  final tuserstreak = 1;
  setUp(() {
    mockHiveInterface = MockHiveInterface();
    mockBox = MockBox();
    datasource = UserInfoLocalDataSource(mockHiveInterface);
  });

  group('Save user streak on cache', () {
    test('should run without throw exception', () async {
      //arrange
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      //act
      await datasource.cacheUserStreak(tuserstreak);
      //assert
      verify(mockBox.put('userStreak', tuserstreak));
      verify(mockHiveInterface.openBox('userInfo'));
    });
    test('When not able to cache, throw cacheException', () async {
      //arrange
      when(mockBox.put('userStreak', tuserstreak)).thenThrow(Exception());
      //assert
      expect(() => datasource.cacheUserStreak(tuserstreak),
          throwsA(isA<CacheException>()));
    });
  });
  group('Get user streak from cache', () {
    test('should return user streak from cache', () async {
      //arrange
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.get('userStreak')).thenAnswer((_) async => tuserstreak);
      //act
      final streak = await datasource.getStreak();
      //assert
      expect(streak, tuserstreak);
    });
    test('should throw CacheException when not able to retrieve from cache',
        () async {
      //arrange
      when(mockBox.get('userStreak')).thenThrow(Exception());
      //assert
      expect(() => datasource.getStreak(), throwsA(isA<CacheException>()));
    });
    test('when no cache found, return 0', () async {
      //arrange
      when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockBox);
      when(mockBox.get('userStreak')).thenReturn(null);
      //act
      final result = await datasource.getStreak();
      //assert
      expect(result, 0);
    });
  });
}
