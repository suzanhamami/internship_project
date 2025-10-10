// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'comparison_bloc.dart';

@immutable
sealed class ComparisonState {}

final class ComparisonInitial extends ComparisonState {}

final class ComparisonLoading extends ComparisonState {}

class ComparisonSuccess extends ComparisonState {
  final ComparisonResultEntity comparisonResultEntity;
  ComparisonSuccess({
    required this.comparisonResultEntity,
  });
}

class ComparisonError extends ComparisonState {
  final String message;
  ComparisonError({required this.message});
}
