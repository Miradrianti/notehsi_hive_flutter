import 'dart:convert';

import 'package:aplikasi_catatan/exception/cache_exception.dart';
import 'package:aplikasi_catatan/service/user/user_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ulid/ulid.dart';

import '../../model/user_model.dart';

class UserLocalServiceImpl implements UserService {
  UserLocalServiceImpl();

  Future<Box> get _box async => Hive.box('user');

   @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final box = await _box;

      final data = await box.get(email);

      if (data != null && data is String) {
        final user = UserModel.fromJson(jsonDecode(data));

        await box.put('authentication', user.id);

        return user;
      } else {
        throw Exception('this email is not registered');
      }
    } catch (e) {
    throw CacheException(e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final ulid = Ulid().toString();

      final data = UserModel(
        id: ulid,
        name: name,
        email: email,
        // password: password,
      );

      final box = await _box;

      await box.put(email, jsonEncode(data.toJson()));

      await box.put('authentication', email);

      return data;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<UserModel?> user() async {
    try {
      final box = await _box;

      final token = await box.get('authentication');

      if (token != null && token is String) {
        final data = await box.get(token);

        if (data != null && data is String) {
          return UserModel.fromJson(jsonDecode(data));
        }

        throw Exception('Please register or log in to your account');
      } else {
        throw Exception('Please register or log in to your account');
      }
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Future<bool> logout() async {
    final box = await _box;

    await box.delete('authentication');

    return true;
  }
}
