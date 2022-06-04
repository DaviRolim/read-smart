// Mocks generated by Mockito 5.2.0 from annotations
// in read_smart/test/data/repositories/user_info_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:hive/hive.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:read_smart/core/network/network_info.dart' as _i3;
import 'package:read_smart/data/datasources/user_info_local_data_source.dart'
    as _i5;
import 'package:read_smart/data/datasources/user_info_remote_data_source.dart'
    as _i6;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeHiveInterface_0 extends _i1.Fake implements _i2.HiveInterface {}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i3.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
}

/// A class which mocks [UserInfoLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserInfoLocalDataSource extends _i1.Mock
    implements _i5.UserInfoLocalDataSource {
  MockUserInfoLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.HiveInterface get hive => (super.noSuchMethod(Invocation.getter(#hive),
      returnValue: _FakeHiveInterface_0()) as _i2.HiveInterface);
  @override
  _i4.Future<int> getStreak() =>
      (super.noSuchMethod(Invocation.method(#getStreak, []),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<void> cacheUserStreak(int? streak) =>
      (super.noSuchMethod(Invocation.method(#cacheUserStreak, [streak]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}

/// A class which mocks [UserInfoRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserInfoRemoteDataSource extends _i1.Mock
    implements _i6.UserInfoRemoteDataSource {
  MockUserInfoRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<int> increaseUserStreakRemote(String? userID) => (super
      .noSuchMethod(Invocation.method(#increaseUserStreakRemote, [userID]),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<int> getUserStreak(String? userID) =>
      (super.noSuchMethod(Invocation.method(#getUserStreak, [userID]),
          returnValue: Future<int>.value(0)) as _i4.Future<int>);
}
