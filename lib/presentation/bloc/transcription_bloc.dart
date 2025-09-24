import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/domain/entity/transcript_entity.dart';
import 'package:internship_project/domain/repository/transcript_repo.dart';
part 'transcription_event.dart';
part 'transcription_state.dart';

class TranscriptionBloc extends Bloc<TranscriptionEvent, TranscriptionState> {
  final TranscriptRepo transcriptRepo;
  TranscriptionBloc({required this.transcriptRepo})
    : super(TranscriptionInitial()) {
    on<AudioUploaded>((event, emit) async {
      emit(AudioUploading());
      try {
        final uploadResult = await transcriptRepo.uploadAudio(
          audioFile: event.file,
        );
        uploadResult.fold(
          (failure) => emit(TranscriptionError(message: failure.message)),
          (uploadUrl) async {
            emit(AudioUploadedSuccessfully(response: uploadUrl));
            final transcribeResult = await transcriptRepo.transcribeAudio(
              uploadUrl: uploadUrl,
            );
            transcribeResult.fold(
              (failure) => emit(TranscriptionError(message: failure.message)),
              (transcriptId) async {
                emit(TranscriptionLoading(transcriptId: transcriptId));
                final transcriptResult = await transcriptRepo.getTranscript(
                  transcriptId: transcriptId,
                );
                transcriptResult.fold(
                  (failure) =>
                      emit(TranscriptionError(message: failure.message)),
                  (transcriptEntity) {
                    emit(TranscriptionReady(transcript: transcriptEntity));
                  },
                );
              },
            );
          },
        );
      } catch (e, s) {
        print("from bloc layer");
        print(s);
        emit(TranscriptionError(message: e.toString()));
      }
    });
  }
}
