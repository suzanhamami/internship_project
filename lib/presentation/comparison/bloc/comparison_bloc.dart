import 'package:bloc/bloc.dart';
import 'package:internship_project/domain/use_case/compare_texts.dart';
import 'package:meta/meta.dart';

part 'comparison_event.dart';
part 'comparison_state.dart';

class ComparisonBloc extends Bloc<ComparisonEvent, ComparisonState> {
  final CompareTextsUseCase compareTextsUseCase;
  ComparisonBloc({required this.compareTextsUseCase})
    : super(ComparisonInitial()) {
    on<ComparisonRequested>((event, emit) {
      emit(ComparisonLoading());
      try {
        final score = compareTextsUseCase.call(
          originalText: event.originalText,
          userText: event.userText,
        );
        final wrongWords = compareTextsUseCase.getWrongWords();
        emit(ComparisonSuccess(score: score, wrongWords: wrongWords));
      } catch (e) {
        emit(ComparisonError(message: "Unexpected error: ${e.toString()}"));
      }
    });
  }
}
