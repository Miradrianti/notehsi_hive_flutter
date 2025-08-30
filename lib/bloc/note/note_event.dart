part of 'note_bloc.dart';

sealed class NoteEvent {}

class GetNoteEvent extends NoteEvent {}

class CreateNoteEvent extends NoteEvent {
  final String title;
  final String content;

  CreateNoteEvent({required this.title, required this.content});
}

class UpdateNoteEvent extends NoteEvent {
  final String id;
  final String title;
  final String content;

  UpdateNoteEvent({
    required this.id,
    required this.title,
    required this.content,
  });
}

class DeleteNoteEvent extends NoteEvent {
  final String id;

  DeleteNoteEvent(this.id);
}
