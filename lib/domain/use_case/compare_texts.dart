// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:internship_project/core/error/exception.dart';
import 'package:internship_project/core/error/failure.dart';
import 'package:internship_project/core/utils/levenshtien_alg.dart';
import 'package:internship_project/domain/entity/comparison_result_entity.dart';

class CompareTextsUseCase {
  final LevenshtienAlg comparer;
  CompareTextsUseCase({required this.comparer});
  Either<Failure, ComparisonResultEntity> call({
    required String originalText,
    required String userText,
  }) {
    try {
      final comparisonResult = comparer.compareText(
        originalText: originalText,
        userText: userText,
      );
      return Right(comparisonResult);
    } on InvalidLanguageException catch (e) {
      return Left(InvalidLanguageFailure(message: e.message));
    } catch (e) {
      return Left(
        UnexpectedFailure(message: "Unexpected error: ${e.toString()}"),
      );
    }
  }
}
