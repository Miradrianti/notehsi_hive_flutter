import 'dart:convert';

import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ulid/ulid.dart';

class NoteLocalService {
  NoteLocalService._();

  static Future<Box> get _box async {
    await Hive.initFlutter(); 
    return await Hive.openBox<String>('note');
  }
  
  static Future<List<NoteModel>> getNotes() async {
    final box = await _box;
    return box.values
        .map((e) => NoteModel.fromJson(jsonDecode(e)))
        .toList();
  }

  static Future<NoteModel> addNote({
    required String username,
    required String title,
    required String content,
    required List<String> tags,
  }) async {
    final ulid = Ulid().toString();

    final note = NoteModel.addNote(
      username: username, 
      title: title, 
      content: content, 
      createdTime: DateTime.now(),
      tags: tags,
    );

    final box = await _box;
    await box.put(ulid, jsonEncode(note.toJson()));
    return note;
  }

  static Future<NoteModel?> updateNote(NoteModel note) async {
  final box = await _box;
  final oldRaw = box.get(note.id);
  if (oldRaw == null) return null;

  final oldNote = NoteModel.fromJson(jsonDecode(oldRaw));
  final updated = oldNote.copyWith(
    title: note.title,
    content: note.content,
    tags: note.tags,
  );

  await box.put(note.id, jsonEncode(updated.toJson()));
  return updated;
}

  static Future<void> deleteNote(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  static Future<void> saveAll() async {
    final box = await _box;
    await box.flush();
  }
}