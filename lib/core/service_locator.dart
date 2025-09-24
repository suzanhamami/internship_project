import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internship_project/presentation/bloc/transcription_bloc.dart';
import 'package:internship_project/data/data_source/transcription_data_source.dart';
import 'package:internship_project/data/repository_imp/transcript_repo_imp.dart';
import 'package:internship_project/domain/repository/transcript_repo.dart';

GetIt getIt = GetIt.instance;
void setUpLocator() async {
  getIt.registerLazySingleton<Dio>(() => Dio());
  //service :
  getIt.registerLazySingleton<TranscriptionDataSource>(
    () => TranscriptionDataSource(dio: getIt<Dio>()),
  );
  //repo:
  getIt.registerLazySingleton<TranscriptRepo>(
    () => TranscriptRepoImp(transcriptionDataSource: getIt<TranscriptionDataSource>()),
  );
  //bloc :
  getIt.registerFactory<TranscriptionBloc>(
    () => TranscriptionBloc(transcriptRepo: getIt<TranscriptRepo>()),
  );
}
