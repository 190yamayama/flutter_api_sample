import 'package:flutter/material.dart';
import 'package:flutter_api_sample/api/qitta/model/QiitaUser.dart';
import 'package:flutter_api_sample/viewModel/HomeScreenViewModel.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qiita 新着記事一覧"),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => context.read<HomeScreenViewModel>().refresh(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh:() => context.read<HomeScreenViewModel>().refresh(context),
        child: ListView.builder(
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

            return Container(
              child: rowWidget(context, index),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
              ),
            );
          },
          itemCount: context.watch<HomeScreenViewModel>().articles.length,
        ),
      ),
    );
  }

  Widget rowWidget(BuildContext context, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        spacing: 5.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Flexible(child:
          Text(
            (article.user?.displayUserName ?? QiitaUser.anonymousUserName) ,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          )
          ),
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Followers",
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
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
              child: FlatButton(
                  child: Text(
                    "${article.title}",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontSize: 16
                    ),
                  ),
                  onPressed: () async {
                    context.read<HomeScreenViewModel>().moveWebViewScreen(context, index);
                  }
              )
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
            style:
            TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                backgroundColor: tagColor,
            )
        ),
      )

    }).toList();
    return Wrap(spacing: 5.0, crossAxisAlignment: WrapCrossAlignment.center, children: tags);
  }

  Widget postedDateRow(BuildContext context, int index) {
    var article = context.read<HomeScreenViewModel>().articles[index];
    return Wrap(
        spacing: 0.0,
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
        spacing: 5.0,
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
