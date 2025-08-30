import 'package:aplikasi_catatan/components/bottom_bar.dart';
import 'package:aplikasi_catatan/components/top_bar.dart';
import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:flutter/material.dart';

class WriteNote extends StatefulWidget {
  final String? ulid;
  final NoteModel? note;

  const WriteNote({
    super.key, 
    this.note, 
    this.ulid,
  });

  static const String routeName = '/note';

  @override
  State<WriteNote> createState() => _WriteNoteState();
}

class _WriteNoteState extends State<WriteNote> {
  
  late TextEditingController titleController;
  late TextEditingController contentController;

  final bool _isBottomSheetOpen = false;

   @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? "");
    contentController = TextEditingController(text: widget.note?.content ?? "");
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.simple('back'),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Judul",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Mulai tulis ...",
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (_isBottomSheetOpen) Divider(),
            // TagInputField(
            //   initialTags: widget.note?.tags ?? [],
            //   enabled: widget.ulid == null,
            // ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(
        titleController: titleController, 
        contentController: contentController,
      )
    );
  }
}