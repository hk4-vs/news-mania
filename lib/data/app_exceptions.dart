class AppExceptions implements Exception {
  final String? _message;
  final String? _prefix;

  AppExceptions([this._message, this._prefix]);

  // @override
  // ignore: annotate_overrides
  String toString() {
    return '$_prefix $_message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, "Error During Communication");
}

class BedRequestException extends AppExceptions {
  BedRequestException([String? message]) : super(message, "Invalid Request");
}

class UnAuthrizedException extends AppExceptions {
  UnAuthrizedException([String? message])
      : super(message, "Unauthrized Request");
}

class InvalidInputValueException extends AppExceptions {
  InvalidInputValueException([String? message])
      : super(message, "Invalid Request");
}
