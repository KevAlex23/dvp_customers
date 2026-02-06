abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}