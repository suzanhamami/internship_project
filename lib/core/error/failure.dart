// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure {
  String message;
  Failure({
    required this.message,
  });
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});
}

class InvalidLanguageFailure extends Failure{
  InvalidLanguageFailure({required super.message});
}

class UnexpectedFailure extends Failure{
  UnexpectedFailure({required super.message});
}