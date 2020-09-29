// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qiita_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _QiitaClient implements QiitaClient {
  _QiitaClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://qiita.com/api';
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchItems(page, perPage, query) async {
    ArgumentError.checkNotNull(page, 'page');
    ArgumentError.checkNotNull(perPage, 'perPage');
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'page': page, 'per_page': perPage, 'query': query};
    _data.removeWhere((k, v) => v == null);
    final Response<List<dynamic>> _result = await _dio.request('/v2/items',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => QiitaArticle.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
