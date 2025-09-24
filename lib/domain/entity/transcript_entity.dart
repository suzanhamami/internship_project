// ignore_for_file: public_member_api_docs, sort_constructors_first
class TranscriptEntity {
  String text;
  List<WordEntity> words;
  TranscriptEntity({
    required this.text,
    required this.words,
  });
}

class WordEntity {
  String text;
  int start;
  int end;
  WordEntity({
    required this.text,
    required this.start,
    required this.end,
  });
}
