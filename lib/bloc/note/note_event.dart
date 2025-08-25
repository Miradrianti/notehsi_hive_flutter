part of 'note_bloc.dart';


abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String id;
  final String username;
  final String title;
  final String content;
  final List<String> tags;
  AddNote(this.id, this.username, this.title, this.content, this.tags);
}
class UpdateNote extends NoteEvent {
  final NoteModel note;
  UpdateNote(this.note);
}
class DeleteNote extends NoteEvent {
  final String id;
  DeleteNote(this.id);
}
class SaveNotes extends NoteEvent {
  final List<NoteModel> notes;
  SaveNotes(this.notes);
}