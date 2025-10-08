// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internship_project/core/utils/text_formatting.dart';

class LevenshtienAlg {
  final TextFormatting formatter;
  LevenshtienAlg({required this.formatter});
  late List<String> originalTokens;
  late List<String> userTokens;
  late List<String> wrongWords;

  void tokenize({required String originalText, required String userText}) {
    originalTokens = formatter.formatText(originalText).split(" ");
    userTokens = formatter.formatText(userText).split(" ");
  }

  String compareText({required String originalText, required String userText}) {
    tokenize(originalText: originalText, userText: userText);
    wrongWords = [];
    int n = originalTokens.length;
    int m = userTokens.length;

    List<List<int>> dpMatrix = List.generate(
      n + 1,
      (index) => List.filled(m + 1, 0),
    );
    //filling first row and column
    for (var i = 0; i < n + 1; i++) {
      dpMatrix[i][0] = i;
    }
    for (var j = 0; j < m + 1; j++) {
      dpMatrix[0][j] = j;
    }
    //filling dp matrix
    for (var i = 1; i < n + 1; i++) {
      for (var j = 1; j < m + 1; j++) {
        int cost = (originalTokens[i - 1] == userTokens[j - 1]) ? 0 : 1;
        dpMatrix[i][j] = [
          dpMatrix[i - 1][j] + 1,
          dpMatrix[i][j - 1] + 1,
          dpMatrix[i - 1][j - 1] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    //backtracking
    var i = n, j = m;
    while (i > 0 || j > 0) {
      if (i > 0 && j > 0 && originalTokens[i - 1] == userTokens[j - 1]) {
        i--;
        j--;
      } else if (j > 0 && dpMatrix[i][j] == dpMatrix[i][j - 1] + 1) {
        // wrongWords.add(originalTokens[i - 1]);
        j--;
      } else if (i > 0 &&
          j > 0 &&
          dpMatrix[i][j] == dpMatrix[i - 1][j - 1] + 1) {
        wrongWords.add(originalTokens[i - 1]);
        i--;
        j--;
      } else if (i > 0 && dpMatrix[i][j] == dpMatrix[i - 1][j] + 1) {
        wrongWords.add(originalTokens[i - 1]);
        i--;
      }
    }
    wrongWords = wrongWords.reversed.toList();
    print(dpMatrix);
    print(wrongWords);
    int correctWords = (n - wrongWords.length);
    String score = "$correctWords/$n";
    return score;
  }
}
