import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:internship_project/core/error/failure.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';

abstract class TranscriptRepo {
  Future<Either<Failure, TranscriptEntity>> getTranscript({required String transcriptId});
  Future<Either<Failure, String>> uploadAudio({required File audioFile});
  Future<Either<Failure, String>> transcribeAudio({required String uploadUrl});
}
