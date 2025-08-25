import 'package:aplikasi_catatan/bloc/note/note_bloc.dart';
import 'package:aplikasi_catatan/components/note_card.dart';
import 'package:aplikasi_catatan/components/regular_text.dart';
import 'package:aplikasi_catatan/model/note_model.dart';
import 'package:aplikasi_catatan/service/note/local_service.dart';
import 'package:aplikasi_catatan/view/write_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> notes = [];
  bool isLoading = false;
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                context.read<NoteBloc>().add(LoadNotes());
              },
              child: notes.isEmpty
                  ? _buildEmptyState()
                  : _buildNotesList(),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{ 
            final result = await Navigator.pushNamed(
              context,
              WriteNote.routeName,
            );
            if (result == true) {
              await Future.delayed(const Duration(milliseconds: 100));
              LoadNotes();
            }
          },
          backgroundColor: Color.fromRGBO(57, 70, 117, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80),
          ),
          child: const Icon(Icons.add, size: 30,),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/icon1.png',
              width: 245,
              height: 219,
            ),
            RegularText.title('Start Your Journey'),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: RegularText.description2(
                  'Every big step start with small step. \n'
                  'Notes your first idea and start your journey!',
              ),
            ),
          ]
        ), 
      ),
    );
  }

Widget _buildNotesList() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
        key: Key(note.id.toString()),
        background: Container(
          color: Colors.grey,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) async {
          await NoteLocalService.deleteNote(note.id);
          if (!mounted) return;
          setState(() => notes.removeAt(index));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Catatan dihapus"))
          );
        },
        child: NotesCard(
          note: note,
          onTap: () {
            Navigator.pushNamed(context, WriteNote.routeName);
          },
          onDelete: () async {
            await NoteLocalService.deleteNote(note.id);
            if (!mounted) return;
            setState(() => notes.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Catatan dihapus"))
            );
          }
        )
        );
      },
    );
  }
}