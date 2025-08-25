import 'package:ulid/ulid.dart';

class NoteModel {
  final String id;
  final String username;
  final String title;
  final String content;
  final DateTime createdTime;
  final List<String> tags;

  NoteModel({
    required this.id, 
    required this.username, 
    required this.title, 
    required this.content, 
    required this.createdTime,
    this.tags = const [],
  });

   NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    String? username,
    DateTime? createdTime,
    List<String>? tags,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      username: username ?? this.username,
      createdTime: createdTime ?? this.createdTime,
      tags: tags ?? this.tags,
    );
  }

  NoteModel.addNote({
    required this.username, 
    required this.title, 
    required this.content, 
    required this.createdTime,
    this.tags = const [],
  })
    : id = Ulid().toString();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'title': title,
      'content': content,
      'createdTime': createdTime.toIso8601String(),
      'tags': tags.join(","),
    };
  }
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      username: map['username'],
      title: map['title'],
      content: map['content'],
      createdTime: DateTime.parse(map['createdTime']),
      tags: (map['tags'] as String).isEmpty
          ? []
          : (map['tags'] as String).split(","),
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
      id: json['id'],
      username: json['username'],
      title: json['title'],
      content: json['content'],
      createdTime: DateTime.tryParse(json['createdTime'] ?? '') ?? DateTime.now(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );

  Map<String, dynamic> toJson() => {
      "id": id,
      "username": username,
      "title": title,
      "content": content,
      "createdTime": createdTime.toIso8601String(),
      "tags": tags,
    };

  // copy({required String title, required String content, required String createdTime,}) {}
}