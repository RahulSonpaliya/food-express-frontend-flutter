class Failure {
  final int statusCode;
  final String message;
  Failure(this.statusCode, this.message);
}

class SessionExpiry extends Failure{
  SessionExpiry(int statusCode, String message) : super(statusCode, message);
}

class AppVersionUpdate extends Failure{
  AppVersionUpdate(int statusCode, String message) : super(statusCode, message);
}

class ServerError extends Failure{
  ServerError(int statusCode, String message) : super(statusCode, message);
}

class TimeoutError extends Failure{
  TimeoutError(int statusCode, String message) : super(statusCode, message);
}

class UnknownError extends Failure{
  UnknownError(int statusCode, String message) : super(statusCode, message);
}

class NoInternetError extends Failure{
  NoInternetError(int statusCode, String message) : super(statusCode, message);
}