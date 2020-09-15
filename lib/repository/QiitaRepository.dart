
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api_sample/api/qitta/QiitaClient.dart';
import 'package:flutter_api_sample/api/qitta/model/QiitaArticle.dart';

class QiitaRepository {

  final QiitaClient _client;

  QiitaRepository({QiitaClient client}):
        _client = client ?? QiitaClient(Dio())
  ;

  Future<List<QiitaArticle>> fetchArticle(int page, int perPage, String query) async {
    return await _client.fetchItems(page, perPage, query)
        .then((value) => value)
        .catchError((e) {
          log(e);
          return [];
        });
  }
}