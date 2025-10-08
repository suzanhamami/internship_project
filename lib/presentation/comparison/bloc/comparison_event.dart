// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comparison_bloc.dart';

@immutable
sealed class ComparisonEvent {}

class ComparisonRequested extends ComparisonEvent {
  final TranscriptEntity originalText;
  final TranscriptEntity userText;
  ComparisonRequested({
    required this.originalText,
    required this.userText,
  });
}
