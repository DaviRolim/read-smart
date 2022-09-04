import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../repositories/user_info_repository.dart';

class GetUserInfo {
  final UserInfoRepository userInfoRepository;
  GetUserInfo(this.userInfoRepository);

  Future<Either<Failure, int>> getUserStreak(userID) async {
    return await userInfoRepository.getUserStreak(userID);
  }
}
