import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const NotesCard({
    super.key,
    required this.note,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 170,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          title: Text(
            note.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: GestureDetector(
            onTap: onTap,
            child: Text(
                softWrap: true,
                maxLines: 7,
                note.content,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
          ),
          ),
        ),
    );
  }
}