import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/core/service_locator.dart';
import 'package:internship_project/core/utils/levenshtien_alg.dart';

void main() {
  setUp(() {
    // reset GetIt for each test to avoid conflicts
    GetIt.I.reset();
    setUpLocator();
  });
  test("Returns score", () {
    final comparer = getIt<LevenshtienAlg>();
    final score = comparer.compareText(
      originalText: "I ate an apple",
      userText: "I eat apple",
    );
    print(score);
    expect(score, "2/4");
  });

  test("Score for longer text", () {
    final comparer = getIt<LevenshtienAlg>();
    final score2 = comparer.compareText(
      originalText: "I ate an apple",
      userText: "I eat apple every other day",
    );
    print(score2);
  });

  test("Returns score", () {
    expect(
      getIt<LevenshtienAlg>().compareText(
        originalText: "I ate an apple",
        userText: "I eat apple",
      ),
      "2/4",
    );
  });
}
