// Mocks generated by Mockito 5.2.0 from annotations
// in read_smart/test/domain/usecases/get_user_info_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:read_smart/core/error/failures.dart' as _i5;
import 'package:read_smart/domain/repositories/user_info_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [UserInfoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserInfoRepository extends _i1.Mock
    implements _i3.UserInfoRepository {
  MockUserInfoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, int>> getUserStreak(String? userID) =>
      (super.noSuchMethod(Invocation.method(#getUserStreak, [userID]),
              returnValue: Future<_i2.Either<_i5.Failure, int>>.value(
                  _FakeEither_0<_i5.Failure, int>()))
          as _i4.Future<_i2.Either<_i5.Failure, int>>);
}
