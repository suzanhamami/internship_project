// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionState {}

final class TranscriptionInitial extends TranscriptionState {}

class AudioUploading extends TranscriptionState {}

class AudioUploadedSuccessfully extends TranscriptionState {
  final String response;
  AudioUploadedSuccessfully({required this.response});
}

class TranscriptionError extends TranscriptionState {
  String message;
  TranscriptionError({
    required this.message,
  });
}

class TranscriptionLoading extends TranscriptionState {
  String transcriptId;
  TranscriptionLoading({required this.transcriptId});
}

class TranscriptionReady extends TranscriptionState {
  TranscriptEntity transcript;
  TranscriptionReady({required this.transcript});
}
