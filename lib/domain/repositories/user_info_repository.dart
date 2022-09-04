import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';

abstract class UserInfoRepository {
  Future<Either<Failure, int>> getUserStreak(String userID);
}
