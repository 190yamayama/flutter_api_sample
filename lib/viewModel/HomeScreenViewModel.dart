import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_api_sample/api/qitta/model/QiitaArticle.dart';
import 'package:flutter_api_sample/repository/QiitaRepository.dart';
import 'package:flutter_api_sample/ui/screen/WebViewScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomeScreenViewModel with ChangeNotifier {

  final int perPage = 20; // 取得件数
  final String query = "qiita user:Qiita";

  QiitaRepository _qiitaRepository;

  bool isFinish = false;
  int page = 1;
  List<QiitaArticle> articles = [];

  HomeScreenViewModel([QiitaRepository qiitaRepository]) {
    _qiitaRepository = qiitaRepository ?? QiitaRepository();
  }

  Future<bool> fetchArticle(BuildContext context) async {
    page += 1;
    isFinish = false;

    final progress = ProgressDialog(context);
    progress.show();

    return _qiitaRepository.fetchArticle(page, perPage, query)
        .then((value) {
          articles.addAll(value);
          if (value.length < perPage)
            isFinish = true;
        })
        .catchError((e) {
          progress.hide();
          log(e.toString());
          return Future.value(false);
        })
        .whenComplete(() {
          progress.hide();
          notifyListeners();
          return Future.value(true);
        });
  }

  Future<bool> loadMore() async {
    page += 1;
    isFinish = false;

    return _qiitaRepository.fetchArticle(page, perPage, query)
        .then((value) {
          articles.addAll(value);
          if (value.length < perPage)
            isFinish = true;
        })
        .catchError((e) {
          log(e.toString());
          return Future.value(false);
        })
        .whenComplete(() {
          notifyListeners();
          return Future.value(true);
        });
  }

  Future<bool> refresh(BuildContext context) async {
    page = 0;
    articles.clear();
    isFinish = false;
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
}