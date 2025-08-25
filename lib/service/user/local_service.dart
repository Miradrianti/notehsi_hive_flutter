import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:ulid/ulid.dart';

import '../../model/user_model.dart';

class UserLocalService {
  UserLocalService._();

  static Box get _box => Hive.box('user');

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final ulid = Ulid().toString();

      final data = UserModel.register(
        name: name,
        email: email,
        password: password,
      );

      final box = _box;

      await box.put(ulid, jsonEncode(data.toJson()));

      await box.put('authentication', ulid);

      return data;
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  static Future<UserModel?> user() async {
    try {
      final box = _box;

      final token = await box.get('authentication');

      if (token != null && token is String) {
        final data = await box.get(token);

        if (data != null && data is String) {
          return UserModel.fromJson(jsonDecode(data));
        }

        return null;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  static Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final box = _box;

      final users = box.values
          .whereType<String>()
          .map((e) => UserModel.fromJson(jsonDecode(e)))
          .toList();

      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: () => throw Exception('User not found'),
      );

      await box.put('authentication', user.id);

      return user;
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  static Future<void> logout() async {
    try {
      final box = _box;

      await box.delete('authentication');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
