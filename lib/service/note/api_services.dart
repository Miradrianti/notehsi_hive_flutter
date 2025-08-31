import 'dart:convert';
import 'dart:convert' as convert;

import 'package:aplikasi_catatan/exception/server_exception.dart';
import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:aplikasi_catatan/service/note/note_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class NoteApiServiceImpl implements NoteService{
  
  @override
  Future<NoteModel> create({
    required String title, 
    required String content
  }) async {
    try {
      final url = Uri.https('hsinote.donisaputra.com', 'api/notes');

      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: {
          'title': title,
          'content': content,
        }
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201){
        final token = body['data']['token'];
        final note = NoteModel.fromJson(body['data']['note']);

        final box = Hive.box('note');
        await box.put('token', token);
        await box.put('note', jsonEncode(note.toJson()));

        await box.put('note',token);

      return note;

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
  Future<bool> delete(String id) async {
    try {
      final box = Hive.box('note');
      final token = box.get('token');

      if(token == null) {
        print('Catatan tidak ditemukan');
        return false;
      }

      final url = Uri.https('hsinote.donisaputra.com', '/api/notes/$id');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final box = Hive.box('note');
        await box.delete(id);
        
        final message = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(message);

        return true;
      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
    throw ServerException(e.toString());
    }
  }

  @override
  Future<List<NoteModel>> notes() async{
    try {
      final box = Hive.box('note');
      final token = box.get('token');

      if (token == null) throw Exception('Catatan tidak ditemukan');
        final url = Uri.https('hsinote.donisaputra.com', 'api/notes');
        
        final response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse["data"];
  
        return data.map((e) => NoteModel.fromJson(e)).toList();

      } else {
        throw ServerException(response.body);
      }
    } catch (e) {
    throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> update({
    required String id, 
    required String title, 
    required String content
    }) async {
    try {
      final box = await Hive.box('note');

      final old = await box.get(id);

      if (old != null && old is String) {
        final data = NoteModel.fromJson(jsonDecode(old));

        final latest = data.update(title: title, content: content).toJson();

        await box.put(id, jsonEncode(latest));

        return true;
      }

      throw ServerException('No record data found.');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

}