class ApiResult {
  final int statusCode;
  final dynamic result;
  final String errorMessage;
  ApiResult( this.statusCode, this.result, [this.errorMessage]);
}