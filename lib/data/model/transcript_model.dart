// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:internship_project/domain/entity/transcript_entity.dart';

class TranscriptModel extends TranscriptEntity {
  TranscriptModel({
    required super.text,
  });

  TranscriptModel copyWith({
    String? text,
  }) {
    return TranscriptModel(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory TranscriptModel.fromMap(Map<String, dynamic> map) {
    return TranscriptModel(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TranscriptModel.fromJson(String source) => TranscriptModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TranscriptModel(text: $text)';

  @override
  bool operator ==(covariant TranscriptModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}
