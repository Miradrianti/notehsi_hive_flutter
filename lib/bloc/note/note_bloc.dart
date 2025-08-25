
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/note_model.dart';
import '../../service/note/local_service.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await NoteLocalService.getNotes();
        emit(NoteLoaded(notes));
      } catch (e) {
        emit(NoteError(e.toString()));
      }
    });

    on<AddNote>((event, emit) async {
      await NoteLocalService.addNote(
        username: event.username,
        title: event.title,
        content: event.content,
        tags: event.tags,
      );
      final notes = await NoteLocalService.getNotes();
      emit(NoteLoaded(notes));
    });

    on<UpdateNote>((event, emit) async {
      await NoteLocalService.updateNote(event.note);
      final notes = await NoteLocalService.getNotes();
      emit(NoteLoaded(notes));
    });

    on<DeleteNote>((event, emit) async {
      await NoteLocalService.deleteNote(event.id);
      final notes = await NoteLocalService.getNotes();
      emit(NoteLoaded(notes));
    });

    on<SaveNotes>((event, emit) async {
      await NoteLocalService.saveAll();
      final notes = await NoteLocalService.getNotes();
      emit(NoteLoaded(notes));
    });
    
  }
}
