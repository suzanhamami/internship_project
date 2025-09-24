// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BaseException implements Exception {
  final String message;
  BaseException({required this.message});
}

class ServerException extends BaseException {
  ServerException({required super.message});
}

class TranscriptNotReadyException extends BaseException {
  TranscriptNotReadyException({required super.message});
}

class TranscribingFailedException extends BaseException{
  TranscribingFailedException({required super.message});
}
