class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
}

class InternalServerErrorException implements Exception {
  final String message;
  InternalServerErrorException(this.message);
}

class UnknownException implements Exception {
  final String message;
  UnknownException(this.message);
}
