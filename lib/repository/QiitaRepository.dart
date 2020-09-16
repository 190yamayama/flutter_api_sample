
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api_sample/api/ApiResult.dart';
import 'package:flutter_api_sample/api/qitta/QiitaClient.dart';
import 'package:flutter_api_sample/api/qitta/model/QiitaArticle.dart';

class QiitaRepository {

  final QiitaClient _client;

  QiitaRepository({QiitaClient client}):
        _client = client ?? QiitaClient(Dio())
  ;

  Future<ApiResult> fetchArticle(int page, int perPage, String query) async {
    // パラメータチェック
    if (page == null || perPage == null || query == null) {
      // retrofitのパラメータチェックで引っ掛かったらcatchErrorで拾えない！（retrofit側でなんとかして欲しい）
      // ので、先にチェックしとく
      return ApiResult(0, null, "引数が無効です");
    }
    return await _client.fetchItems(page, perPage, query)
        .then((value) =>  ApiResult(200, value))
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
          return ApiResult(errorCode, null, errorMessage);
        });
  }

}