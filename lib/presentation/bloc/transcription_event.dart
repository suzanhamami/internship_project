// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transcription_bloc.dart';

@immutable
sealed class TranscriptionEvent {}

class AudioUploaded extends TranscriptionEvent {
  File file;
  AudioUploaded({required this.file});
}
