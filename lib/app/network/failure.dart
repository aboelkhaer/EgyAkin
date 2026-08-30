class Failure {
  int code;
  String message;
  Map<String, dynamic>? data;

  Failure(this.code, this.message, {this.data});
}
