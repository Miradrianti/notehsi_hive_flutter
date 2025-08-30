part of 'note_bloc.dart';

class NoteState {
  NoteState({
    this.status = StatusEnum.initial,
    this.notes = const [],
    this.error,
  });

  factory NoteState.initial() => NoteState();

  final StatusEnum status;
  final List<NoteModel> notes;
  final Exception? error;

  NoteState copyWith({
    StatusEnum? status,
    List<NoteModel>? notes,
    Exception? error,
  }) {
    return NoteState(
      error: error,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }
}
