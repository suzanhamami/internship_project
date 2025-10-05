// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internship_project/core/utils/levenshtien_alg.dart';

class CompareTextsUseCase {
  final LevenshtienAlg comparer;
  CompareTextsUseCase({required this.comparer});
  String call({required String originalText, required String userText}) {
    return comparer.compareText(originalText: originalText, userText: userText);
  }

  List<String> getWrongWords() => comparer.wrongWords;
}
