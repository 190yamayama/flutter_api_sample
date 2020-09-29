import 'package:flutter_api_sample/api/api_respose_type.dart';
import 'package:flutter_api_sample/repository/qiita_repository.dart';
import 'package:flutter_test/flutter_test.dart';

// テストコマンド
// flutter test test/unit_test.dart
void main() {

  var _repository = QiitaRepository();

  group('Api test', () {

    test("Normal test", () async {

      final int page = 1; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = "qiita user:Qiita";

      final future = await _repository.fetchArticle(page, perPage, query);
      final result = future.result;
      expect(result, isNotNull); // nullはダメ
      expect(result, isNotEmpty); // 空はダメ
      if (result != null) {
        result.forEach((element) {
          expect(element.title, isNotNull);  // 空はダメ
          expect(element.title, isNotEmpty);  // 空はダメ
          expect(element.createdAt, isNotNull); // nullはダメ
          expect(element.body, isNotEmpty); // 空はダメ
          expect(element.tags, isNotNull);  // nullはダメ
          expect(element.tags, isNotEmpty);  // 空はダメ
          expect(element.url, isNotNull);  // nullはダメ
          expect(element.url, isNotEmpty);  // 空はダメ
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