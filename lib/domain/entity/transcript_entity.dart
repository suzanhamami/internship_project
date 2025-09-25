// ignore_for_file: public_member_api_docs, sort_constructors_first
class TranscriptEntity {
  final String text;
  final List<WordEntity> words;
  TranscriptEntity({
    required this.text,
    required this.words,
  });
}

class WordEntity {
  final String text;
  final int start;
  final int end;
  WordEntity({
    required this.text,
    required this.start,
    required this.end,
  });
}
