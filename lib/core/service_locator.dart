import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/core/utils/levenshtien_alg.dart';
import 'package:internship_project/core/utils/text_formatting.dart';
import 'package:internship_project/domain/use_case/compare_texts.dart';
import 'package:internship_project/presentation/comparison/bloc/comparison_bloc.dart';
import 'package:internship_project/presentation/transcription/bloc/transcription_bloc.dart';
import 'package:internship_project/data/data_source/transcription_data_source.dart';
import 'package:internship_project/data/repository_imp/transcript_repo_imp.dart';
import 'package:internship_project/domain/repository/transcript_repo.dart';

GetIt getIt = GetIt.instance;
Future<void> setUpLocator() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  //service :
  getIt.registerLazySingleton<TranscriptionDataSource>(
    () => TranscriptionDataSource(dio: getIt<Dio>()),
  );
  //repo:
  getIt.registerLazySingleton<TranscriptRepo>(
    () => TranscriptRepoImp(
      transcriptionDataSource: getIt<TranscriptionDataSource>(),
    ),
  );
  //usecase :
  getIt.registerLazySingleton<CompareTextsUseCase>(
    () => CompareTextsUseCase(comparer: getIt<LevenshtienAlg>()),
  );
  //bloc :
  getIt.registerFactory<TranscriptionBloc>(
    () => TranscriptionBloc(transcriptRepo: getIt<TranscriptRepo>()),
  );
  getIt.registerFactory<ComparisonBloc>(
    () => ComparisonBloc(compareTextsUseCase: getIt<CompareTextsUseCase>()),
  );
  //textFormatter :
  getIt.registerLazySingleton<TextFormatting>(() => TextFormatting());
  //comparer :
  getIt.registerFactory<LevenshtienAlg>(
    () => LevenshtienAlg(formatter: getIt<TextFormatting>()),
  );
}
