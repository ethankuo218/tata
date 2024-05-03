import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tata/src/core/models/app_user_info.dart';
import 'package:tata/src/core/repositories/user_repository.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  late AppUserInfo? _currentUserInfo;

  @override
  Future<AppUserInfo?> build(String? uid) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);

    final AppUserInfo? userInfo =
        uid != null ? await userRepository.getUserInfo(uid) : null;

    _currentUserInfo = userInfo;
    state = AsyncData(userInfo);

    return userInfo;
  }

  // Edit User Name
  Future<void> editUserName(String name) async {
    final UserRepository userRepository = ref.read(userRepositoryProvider);

    await userRepository.editUserInfo(uid: _currentUserInfo!.uid, name: name);

    final AppUserInfo updatedUserInfo =
        await userRepository.getUserInfo(_currentUserInfo!.uid);

    state = AsyncData(updatedUserInfo);
  }
}
