import 'package:flutter_api_sample/api/api_response_type.dart';
import 'package:flutter_api_sample/api/qitta/model/qiita_article.dart';
import 'package:flutter_api_sample/api/qitta/qiita_client.dart';
import 'package:flutter_api_sample/repository/qiita_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'api_mock.dart';

// テストコマンド
// flutter test test/unit_test.dart
//
// 「テストコードは外部のリソースに依存しない」という原則に沿ってapi通信をMock化する。
// でも、unitテストではapi通信は阻害されないので普通にapiを叩くこともできる
//
void main() {

  // retrofitはdioを使用しているのでdioのモックを作成
  // 参考)https://github.com/flutterchina/dio/issues/374
  final _dioAdapterMock = DioAdapterMock();
  final _dio = Dio();

  setUp(() {
    _dio.httpClientAdapter = _dioAdapterMock;
  });

  tearDown(() {
    _dio.close(force: true);
    _dioAdapterMock.close(force: true);
  });

  // dioのfetchが走ったらダミーのレスポンスを返却するようにインターセプト
  when(_dioAdapterMock.fetch(any, any, any)).thenAnswer((_) async => okHttpResponse);

  // モックのリポジトリ生成
  var _repository = QiitaRepository(QiitaClient(_dio));

  group('Api test', () {

    test("Normal test", () async {
      final int page = 1; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = "qiita user:Qiita";

      final future = await _repository.fetchArticle(page, perPage, query);
      final result = future.result as List<QiitaArticle>;
      expect(result, isNotNull); // nullはダメ
      expect(result.length, 1); // 1件だけか？
      if (result != null) {
        result.forEach((element) {
          expect(element.title, isNotNull); // 空はダメ
          expect(element.title, isNotEmpty); // 空はダメ
          expect(element.title,
              "FlutterやってみたよPart7（retrofit導入）"); // ダミーデータのタイトルと一致しているか？
          expect(element.createdAt, isNotNull); // nullはダメ
          expect(element.body, isNotEmpty); // 空はダメ
          expect(element.tags, isNotNull); // nullはダメ
          expect(element.tags, isNotEmpty); // 空はダメ
          expect(element.url, isNotNull); // nullはダメ
          expect(element.url, isNotEmpty); // 空はダメ
        });
      }
    });

    test("Error test wrong page", () async {
      final int page = null; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = "qiita user:Qiita";

      final future = await _repository.fetchArticle(page, perPage, query);
      expect(future.apiStatus.code, ApiResponseType.BadRequest.code);
    });

    test("Error test wrong perPage", () async {
      final int page = 1; // ページ番号
      final int perPage = null; // 取得件数
      final String query = "qiita user:Qiita";

      final future = await _repository.fetchArticle(page, perPage, query);
      expect(future.apiStatus.code, ApiResponseType.BadRequest.code);
    });

    test("Error test wrong query", () async {
      final int page = 1; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = null;

      final future = await _repository.fetchArticle(page, perPage, query);
      expect(future.apiStatus.code, ApiResponseType.BadRequest.code);
    });
  });

}