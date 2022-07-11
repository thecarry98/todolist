final String tableNotes = 'notes';

List<Note> list = [];
List<Note> listComp = [];
List<Note> listIncomp = [];

class NoteFields {
  static final List<String> values = [id, title, check];
  static final String id = '_id';
  static final String title = 'title';
  static final String check = 'isCheck';
}

class Note {
  final int? id;
  final String? title;
  bool? check;
  Note({this.id, this.title, this.check});

  Note copy({
    int? id,
    String? title,
    bool? check,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        check: check ?? this.check,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        check: json[NoteFields.check] == 1,
        title: json[NoteFields.title] as String,
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.check: check,
      };
}
