import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:read_smart/core/error/exceptions.dart';
import 'package:read_smart/data/datasources/user_info_remote_data_source.dart';

import '../../fixtures/fixture_reader.dart';
import 'user_info_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late UserInfoRemoteDataSource datasource;
  final userID = 'SOMEHASHRANDOMID';
  final tstreak = 3;

  setUp(() {
    mockClient = MockClient();
    datasource = UserInfoRemoteDataSource(mockClient);
  });
  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('streak.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('Get user streak', () {
    test('should return the streak when response code is 200', () async {
      //Arrange
      setUpMockHttpClientSuccess200();
      //Act
      final response = await datasource.getUserStreak(userID);
      // Assert
      expect(tstreak, response);
    });
    test('should return ServerException when response code is 200', () async {
      //Arrange
      setUpMockHttpClientFailure404();
      // Assert
      expect(() => datasource.getUserStreak(userID),
          throwsA(isA<ServerException>()));
    });
  });
}
