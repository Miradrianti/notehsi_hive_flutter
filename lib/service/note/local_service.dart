import 'dart:convert';

import 'package:aplikasi_catatan/exception/cache_exception.dart';
import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:aplikasi_catatan/service/note/note_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ulid/ulid.dart';

class NoteLocalServiceImpl implements NoteService {
  Future<Box> get _box async {

    await Hive.initFlutter();

    return await Hive.openBox('note');
  }

  @override
  Future<List<NoteModel>> notes() async {
    try {
      final box = await _box;

      final values = box.values.toList();

      return values.map((e) {
        return NoteModel.fromJson(jsonDecode(e));
      }).toList();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<NoteModel> create({required String title, required String content}) async {
    try {
      final box = await _box;

      final ulid = Ulid().toString();

      final date = DateTime.now();

      final data = NoteModel(
        id: ulid,
        title: title,
        content: content,
        createdAt: date,
        updatedAt: date,
      );

      await box.put(ulid, jsonEncode(data.toJson()));
      
      return data;

    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> update({
    required String id,
    required String title,
    required String content,
  }) async {
    try {
      final box = await _box;

      final old = await box.get(id);

      if (old != null && old is String) {
        final data = NoteModel.fromJson(jsonDecode(old));

        final latest = data.update(title: title, content: content).toJson();

        await box.put(id, jsonEncode(latest));

        return true;
      }

      throw CacheException('No record data found.');
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      final box = await _box;

      await box.delete(id);

      return true;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}
