import 'package:flutter_api_sample/repository/QiitaRepository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Api test', () {
    
    test("Normal test", () async {
      final int page = 1; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = "qiita user:Qiita";

      final repository = QiitaRepository();
      final future = await repository.fetchArticle(page, perPage, query);
      expect(future.result.length, 20);
    });

    test("Error test wrong page", () async {
      final int page = null; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = "qiita user:Qiita";

      final repository = QiitaRepository();
      final future = await repository.fetchArticle(page, perPage, query);
      expect(future.statusCode, 0);

    });

    test("Error test wrong perPage", () async {
      final int page = 1; // ページ番号
      final int perPage = null; // 取得件数
      final String query = "qiita user:Qiita";

      final repository = QiitaRepository();
      final future = await repository.fetchArticle(page, perPage, query);
      expect(future.statusCode, 0);

    });

    test("Error test wrong query", () async {
      final int page = 1; // ページ番号
      final int perPage = 20; // 取得件数
      final String query = null;

      final repository = QiitaRepository();
      final future = await repository.fetchArticle(page, perPage, query);
      expect(future.statusCode, 0);

    });
  });

}