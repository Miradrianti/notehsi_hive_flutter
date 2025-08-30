import 'dart:convert';

import 'package:aplikasi_catatan/exception/server_exception.dart';
import 'package:aplikasi_catatan/model/user_model.dart';
import 'package:aplikasi_catatan/service/user/user_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class UserApiServiceImpl implements UserService{
  @override
  Future<UserModel> login({
    required String email, 
    required String password
  }) async {
    try {
      final url = Uri.https(
        'hsinote.donisaputra.com',
        'api/login'
      );
      final response = await http.post(
        url,
        body: {'email': email, 'password': password}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final token = data['access_token'];

        final box = Hive.box('authentication');
        await box.put('token', token);

        return UserModel.fromJson(data['data']['user']);
        
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
    throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final box = Hive.box('authentication');

      await box.delete('authentication');

    return true;

    } catch (e) {
    throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> register({
    required String name, 
    required String email, 
    required String password
    }) async {
      try {
      final url = Uri.https(
        'hsinote.donisaputra.com',
        'api/register'
      );
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name, 
          'email': email, 
          'password': password,
        })
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = body['data']['token'];
        final user = UserModel.fromJson(body['data']['user']);

        final box = Hive.box('authentication');

        await box.put('token', token);
        await box.put('user', jsonEncode(user.toJson()));

        await box.put('authentication', email);

        return user;
      
      } else if (response.statusCode == 422 ){
        final message = body['meta']['message'];
        throw ServerException(message);
      } else {
        throw ServerException('Unknown error: ${response.body}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> user() async {
    try {
      final box = Hive.box('authentication');
      final token = box.get('token');

  if (token == null) throw Exception('Belum login / token tidak ada');
      final url = Uri.https(
        'hsinote.donisaputra.com',
        'api/user'
      );
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body)['data']['user']);
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
    throw ServerException(e.toString());
    }
  }
  
}