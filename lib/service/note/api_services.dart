import 'dart:convert';

import 'package:aplikasi_catatan/exception/server_exception.dart';
import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:aplikasi_catatan/service/note/note_service.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class NoteApiServiceImpl implements NoteService{
  
  @override
  Future<bool> create({
    required String title, 
    required String content
  }) async {
    try {
      final url = Uri.https('hsinote.donisaputra.com', 'api/notes');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
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

      return true;
      } else {
        print('Responce: ${response.body}');
        return false;
      }
    } catch (e) {
    throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<NoteModel>> notes() async{
    try {


      final box = Hive.box('note');

      final values = box.values.toList();

      return values.map((e) {
        return NoteModel.fromJson(jsonDecode(e));
      }).toList();


    } catch (e) {
    throw UnimplementedError();
    }
  }

  @override
  Future<bool> update({required String id, required String title, required String content}) {
    // TODO: implement update
    throw UnimplementedError();
  }

}