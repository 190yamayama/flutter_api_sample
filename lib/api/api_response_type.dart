enum ApiResponseType {
  OK,
  BadRequest,
  Forbidden,
  NotFound,
  MethodNotAllowed,
  Conflict,
  InternalServerError,
  other,
}

extension ApiErrorTypeExtension on ApiResponseType {

  get code {
    switch (this) {
      case ApiResponseType.OK:
        return 200;
      case ApiResponseType.BadRequest:
        return 400;
      case ApiResponseType.Forbidden:
        return 403;
      case ApiResponseType.NotFound:
        return 404;
      case ApiResponseType.MethodNotAllowed:
        return 405;
      case ApiResponseType.Conflict:
        return 409;
      case ApiResponseType.InternalServerError:
        return 500;
      default:
        return null;
    }
  }

  get message {
    switch (this) {
      case ApiResponseType.OK:
        return "";
      case ApiResponseType.BadRequest:
        return "引数が無効です";
      case ApiResponseType.Forbidden:
        return "オブジェクトを操作する権限がない為、操作できません。";
      case ApiResponseType.NotFound:
        return "パスで参照されたオブジェクトは存在しません。";
      case ApiResponseType.MethodNotAllowed:
        return "メソッドがパスに許可されているメソッドの1つではありません。";
      case ApiResponseType.Conflict:
        return "すでに存在するオブジェクトを作成しようとしました。";
      case ApiResponseType.InternalServerError:
        return "サービスの実行が何らかの原因で失敗しました。";
      default:
        return "サービスの実行が何らかの原因で失敗しました。";
    }
  }
}