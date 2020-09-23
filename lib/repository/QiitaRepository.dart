
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api_sample/api/ApiResponse.dart';
import 'package:flutter_api_sample/api/ApiResposeType.dart';
import 'package:flutter_api_sample/api/qitta/QiitaClient.dart';

class QiitaRepository {

  final QiitaClient _client;

  QiitaRepository({QiitaClient client}):
        _client = client ?? QiitaClient(Dio())
  ;

  Future<ApiResponse> fetchArticle(int page, int perPage, String query) async {
    // パラメータチェック
    if (page == null || perPage == null || query == null) {
      // retrofitのパラメータチェックで引っ掛かったらcatchErrorで拾えない！（retrofit側でなんとかして欲しい）
      // ので、先にチェックしとく
      return ApiResponse(ApiResponseType.BadRequest, null);
    }

    return await _client.fetchItems(page, perPage, query)
        .then((value) =>  ApiResponse(ApiResponseType.OK, value))
        .catchError((e) {
          // エラーハンドリングについてのretrofit公式ドキュメント
          // https://pub.dev/documentation/retrofit/latest/
          int errorCode = 0;
          String errorMessage = "";
          switch (e.runtimeType) {
            case DioError:
              // 失敗した応答のエラーコードとメッセージを取得するサンプル
              // ここでエラーコードのハンドリングると良さげ
              final res = (e as DioError).response;
              log("Got error : ${res.statusCode} -> ${res.statusMessage}");
              errorCode = res.statusCode;
              errorMessage = res.statusMessage;
              break;
            default:
          }
          var apiResponseType = ApiResponse.convert(errorCode);
          // とりあえずここではサーバー側のエラーメッセージを表示するようにしとく
          return ApiResponse(apiResponseType, errorMessage);
        });
  }

}