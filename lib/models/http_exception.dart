class HttpException implements Exception{
  final String messgae;

  HttpException(this.messgae);

  @override
  String toString() {
    // TODO: implement toString
    return messgae;
  }
}