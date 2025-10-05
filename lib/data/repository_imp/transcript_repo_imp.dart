// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:internship_project/core/error/exception.dart';
import 'package:internship_project/core/error/failure.dart';
import 'package:internship_project/data/data_source/transcription_data_source.dart';
import 'package:internship_project/data/model/transcript_model.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';
import 'package:internship_project/domain/repository/transcript_repo.dart';

class TranscriptRepoImp implements TranscriptRepo {
  final TranscriptionDataSource transcriptionDataSource;
  TranscriptRepoImp({required this.transcriptionDataSource});

  @override
  Future<Either<Failure, String>> uploadAudio({required File audioFile}) async {
    try {
      String uploadUrl = await transcriptionDataSource.uploadAudio(
        audioFile: audioFile,
      );
      return Right(uploadUrl);
    } on ServerException catch (e) {
      print("from repo imp upload");
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> transcribeAudio({required String uploadUrl}) async {
    try {
      String transcriptId = await transcriptionDataSource.transcribeAudio(
        uploadUrl: uploadUrl,
      );
      return Right(transcriptId);
    } on ServerException catch (e) {
      print("from repo imp transcribe");
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, TranscriptEntity>> getTranscript({required String transcriptId}) async {
    try {
      TranscriptModel transcriptModel = await transcriptionDataSource
          .getTranscript(transcriptId: transcriptId);
      return Right(transcriptModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on TranscribingFailedException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on TranscriptNotReadyException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }
}
