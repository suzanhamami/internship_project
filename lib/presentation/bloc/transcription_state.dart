// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionState {}

final class TranscriptionInitial extends TranscriptionState {}

final class AudioUploading extends TranscriptionState {}

class AudioUploadedSuccessfully extends TranscriptionState {
  final String response;
  AudioUploadedSuccessfully({required this.response});
}

class TranscriptionError extends TranscriptionState {
  final String message;
  TranscriptionError({
    required this.message,
  });
}

class TranscriptionLoading extends TranscriptionState {
  final String transcriptId;
  TranscriptionLoading({required this.transcriptId});
}

class TranscriptionReady extends TranscriptionState {
  final TranscriptEntity transcript;
  TranscriptionReady({required this.transcript});
}
