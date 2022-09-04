import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:read_smart/domain/repositories/user_info_repository.dart';
import 'package:read_smart/domain/usecases/get_user_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'get_user_info_test.mocks.dart';

@GenerateMocks([UserInfoRepository])
void main() {
  final mockUserInfoRepository = MockUserInfoRepository();
  final userInfoUsecase = GetUserInfo(mockUserInfoRepository);
  final userStreak = 10;
  final userID = '61H38Ju27GAA3F32';

  test('should return user streak from repository', () async {
    when(mockUserInfoRepository.getUserStreak(userID))
        .thenAnswer((_) async => Right(userStreak));
    final result = await userInfoUsecase.getUserStreak(userID);
    verify(mockUserInfoRepository.getUserStreak(userID));
    expect(result, Right(userStreak));
  });
}
