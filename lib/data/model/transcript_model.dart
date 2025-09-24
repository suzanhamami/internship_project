// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';

abstract class ResponseModel {}

class ErrorModel extends ResponseModel {
  String error;
  ErrorModel({required this.error});
}

class TranscriptModel extends TranscriptEntity {
  TranscriptModel({required super.text, required super.words});
  TranscriptModel copyWith({String? text, List<WordModel>? words}) {
    return TranscriptModel(text: text ?? this.text, words: words ?? this.words);
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'text': text,
  //     'words': words.map((x) => x.toMap()).toList(),
  //   };
  // }

  factory TranscriptModel.fromMap(Map<String, dynamic> map) {
    final wordsJson = map['words'] as List<dynamic>? ?? <dynamic>[];
    final word = wordsJson
        .map((e) => WordModel.fromMap(e as Map<String, dynamic>))
        .toList();
    final tr = TranscriptModel(
      text: map['text'] as String,
      words:
           word, // List.generate(map['words'].length, (index) => WordModel.fromMap(map['words'][index]),)
      // List<WordModel>.from(
      // (map['words'] as List<WordModel>).map<WordModel>(
      //   (x) => WordModel.fromMap(x as Map<String, dynamic>),
      // ),
      // ),
    );
    print(tr);
    return tr;
  }

  // String toJson() => json.encode(toMap());

  factory TranscriptModel.fromJson(String source) =>
      TranscriptModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TranscriptModel(text: $text, words: $words)';

  @override
  bool operator ==(covariant TranscriptModel other) {
    if (identical(this, other)) return true;

    return other.text == text && listEquals(other.words, words);
  }

  @override
  int get hashCode => text.hashCode ^ words.hashCode;
}

class WordModel extends WordEntity {
  WordModel({required super.text, required super.start, required super.end});

  WordModel copyWith({String? text, int? start, int? end}) {
    return WordModel(
      text: text ?? this.text,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'text': text, 'start': start, 'end': end};
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      text: map['text'] as String,
      start: map['start'] as int,
      end: map['end'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) =>
      WordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WordModel(text: $text, start: $start, end: $end)';

  @override
  bool operator ==(covariant WordModel other) {
    if (identical(this, other)) return true;

    return other.text == text && other.start == start && other.end == end;
  }

  @override
  int get hashCode => text.hashCode ^ start.hashCode ^ end.hashCode;
}
