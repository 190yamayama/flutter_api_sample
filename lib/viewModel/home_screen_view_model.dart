import 'package:flutter/material.dart';
import 'package:flutter_api_sample/api/api_respose_type.dart';
import 'package:flutter_api_sample/api/qitta/model/qiita_article.dart';
import 'package:flutter_api_sample/repository/qiita_repository.dart';
import 'package:flutter_api_sample/ui/parts/dialogs.dart';
import 'package:flutter_api_sample/ui/screen/web_view_screen.dart';

class HomeScreenViewModel with ChangeNotifier {

  final int perPage = 20; // 取得件数
  final String query = "qiita user:Qiita";

  QiitaRepository _qiitaRepository;

  int page = 1;
  List<QiitaArticle> articles = [];

  HomeScreenViewModel([QiitaRepository qiitaRepository]) {
    _qiitaRepository = qiitaRepository ?? QiitaRepository();
  }

  Future<bool> fetchArticle(BuildContext context) async {
    page += 1;

    final dialogs = Dialogs(context: context);
    dialogs.showLoadingDialog();

    return _qiitaRepository.fetchArticle(page, perPage, query)
        .then((result) {
          if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
            // ロード中のダイアログを閉じる
            dialogs.closeDialog();
            // エラーメッセージのダイアログを表示する
            dialogs.showErrorDialog(result.message);
            notifyListeners();
            return false;
          }

          articles.addAll(result.result);
          // ロード中のダイアログを閉じる
          dialogs.closeDialog();
          notifyListeners();
          return true;
        });
  }

  Future<bool> loadMore(BuildContext context) async {
    page += 1;

    return _qiitaRepository.fetchArticle(page, perPage, query)
        .then((result) {
          if (result == null || result.apiStatus.code != ApiResponseType.OK.code) {
            // エラーメッセージのダイアログを表示する
            final dialogs = Dialogs(context: context);
            dialogs.showErrorDialog(result.message);
            notifyListeners();
            return false;
          }
          articles.addAll(result.result);
          notifyListeners();
          return true;
        });
  }

  Future<bool> refresh(BuildContext context) async {
    page = 0;
    articles.clear();
    notifyListeners();

    return fetchArticle(context);
  }

  void moveWebViewScreen(BuildContext context, int index) {
    var url = articles[index].url;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => WebViewScreen(urlString: url))
    );
  }

  Future<bool> showExitDialog(BuildContext context) {
    final dialogs = Dialogs(context: context);
    return dialogs.showExitDialog();
  }

}