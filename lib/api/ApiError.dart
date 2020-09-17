enum ApiErrorType {
  OK,
  BadRequest,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  Conflict,
  InternalServerError,
  other,
}

extension ApiErrorTypeExtension on ApiErrorType {

  get code {
    switch (this) {
      case ApiErrorType.OK:
        return 200;
      case ApiErrorType.BadRequest:
        return 400;
      case ApiErrorType.Forbidden:
        return 403;
      case ApiErrorType.NotFound:
        return 404;
      case ApiErrorType.MethodNotAllowed:
        return 405;
      case ApiErrorType.Conflict:
        return 409;
      case ApiErrorType.InternalServerError:
        return 500;
      default:
        return null;
    }
  }

}

class ApiError {

  ApiErrorType apiError;

  ApiError({this.apiError});

  static ApiErrorType convert(int errorCode) {
    if (errorCode == ApiErrorType.OK.code) {
      return ApiErrorType.OK;
    } else if (errorCode == ApiErrorType.BadRequest.code) {
      return ApiErrorType.BadRequest;
    } else if (errorCode == ApiErrorType.Forbidden.code) {
      return ApiErrorType.Forbidden;
    } else if (errorCode == ApiErrorType.NotFound.code) {
      return ApiErrorType.NotFound;
    } else if (errorCode == ApiErrorType.MethodNotAllowed.code) {
      return ApiErrorType.MethodNotAllowed;
    } else if (errorCode == ApiErrorType.Conflict.code) {
      return ApiErrorType.Conflict;
    } else if (errorCode == ApiErrorType.InternalServerError.code) {
      return ApiErrorType.InternalServerError;
    } else {
      return ApiErrorType.other;
    }
  }
}
