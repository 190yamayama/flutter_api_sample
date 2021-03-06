import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_sample/api/qitta/model/qiita_user.dart';
import 'package:flutter_api_sample/ui/widget_keys.dart';
import 'package:flutter_api_sample/viewModel/home_screen_view_model.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(),
      child: HomeScreenPage(),
    );
  }

}

class HomeScreenPage extends StatelessWidget {

  Future<bool> _onWillPop(BuildContext context) async {
    return (await context.read<HomeScreenViewModel>().showExitDialog(context)) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          appBar: AppBar(
            key: Key(WidgetKey.KEY_HOME_APP_BAR),
            title: Text(
              "Qiita 新着記事一覧",
              key: Key(WidgetKey.KEY_HOME_APP_BAR_TITLE),
            ),
            backgroundColor: Colors.greenAccent,
            leading: IconButton(
              key: Key(WidgetKey.KEY_HOME_APP_BAR_ICON_BUTTON),
              icon: const Icon(
                Icons.search,
                key: Key(WidgetKey.KEY_HOME_APP_BAR_ICON),
              ),
              onPressed: () => context.read<HomeScreenViewModel>().refresh(context),
            ),
          ),
          body: RefreshIndicator(
            onRefresh:() => context.read<HomeScreenViewModel>().refresh(context),
            child: ListView.builder(
              key: Key(WidgetKey.KEY_HOME_LIST_VIEW),
              itemBuilder: (BuildContext context, int index) {

                var length = context.read<HomeScreenViewModel>().articles.length -1;
                if (index == length) {
                  // 追加読み込み
                  context.read<HomeScreenViewModel>().loadMore(context);
                  // 画面にはローディング表示しておく
                  return new Center(
                    child: new Container(
                      margin: const EdgeInsets.only(top: 8.0),
                      width: 32.0,
                      height: 32.0,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                } else if (index > length) {
                  // ローディング表示より先は無し
                  return null;
                }

                // 行アイテム返却
                return Container(
                  child: rowWidget(context, index),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                );
              },
              itemCount: context.watch<HomeScreenViewModel>().articles.length,
            ),
          ),
        )
    );
  }

  Widget rowWidget(BuildContext context, int index) {
    return Wrap(
      children: [
        userRow(context, index),
        titleRow(context, index),
        tagsRow(context, index),
        postedDateRow(context, index),
        lgtmRow(context, index),
      ],
    );
  }

  Widget userRow(BuildContext context, int index) {
    var article = context.read<HomeScreenViewModel>().articles[index];
    return Wrap(
        spacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                          article.user.profileImageUrl,
                      ),
                  )
              )
          ),
          Text(
            (article.user?.displayUserName ?? QiitaUser.anonymousUserName) ,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
                "Followers",
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.green
                )
            ),
          ),
          Text(
              "${article.user.followersCountString}",
              style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic
              )
          )
        ]
    );
  }

  Widget titleRow(BuildContext context, int index) {
    var article = context.read<HomeScreenViewModel>().articles[index];
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          FlatButton(
              key: Key(WidgetKey.KEY_HOME_LIST_VIEW_ROW_TITLE + "_$index"),
              child: Text(
                "${article.title}",
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 20
                ),
              ),
              onPressed: () async {
                context.read<HomeScreenViewModel>().moveWebViewScreen(context, index);
              }
          )
        ]
    );
  }

  Widget tagsRow(BuildContext context, int index) {
    var article = context.read<HomeScreenViewModel>().articles[index];
    if (article.tags.length <= 0)
      return null;

    var tagColor = Color.fromRGBO(200, 200, 200, 0.5);
    var tags = article.tags.expand((e) => {
      Container(
        margin: const EdgeInsets.all(3.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: tagColor),
          color: tagColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(e.name,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: Colors.black,
              backgroundColor: tagColor,
            )
        ),
      )
    }).toList();

    return Wrap(
        spacing: 8.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: tags
    );
  }

  Widget postedDateRow(BuildContext context, int index) {
    var article = context.read<HomeScreenViewModel>().articles[index];
    return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "を${article.createdAtString}に投稿しました！",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          )
        ]
    );
  }

  Widget lgtmRow(BuildContext context, int index) {
    var article = context.read<HomeScreenViewModel>().articles[index];
    var lgtmColor = Colors.green;
    return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: lgtmColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
                "LGTM",
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: lgtmColor,
                )
            ),
          ),
          Text(
              article.likesCountString,
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              )
          ),
        ]
    );
  }

}
