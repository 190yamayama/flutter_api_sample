import 'package:flutter/material.dart';
import 'package:flutter_api_sample/api/qitta/model/QiitaUser.dart';
import 'package:flutter_api_sample/ui/parts/Dialog.dart';
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
        title: Text("Home Screen"),
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
    var article = context.read<HomeScreenViewModel>().articles[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(child:
                Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange)
                  ),
                  child: Text(
                      (article.user?.displayUserName ?? QiitaUser.anonymousUserName) + "が${article.createdAtString}に投稿しました！",
                      style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic)
                  ),
                ),
              ),
            ]
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green)
                ),
                child: Text(
                    "LGTM",
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.green)
                ),
              ),
              Text(
                  article.likesCountString,
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)
              ),
            ]
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(child:
              FlatButton(
                  child: Text(
                    "${article.title}",
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,),
                  ),
                  onPressed: () async {
                    context.read<HomeScreenViewModel>().moveWebViewScreen(context, index);
                  }
              )
              ),
            ]
        ),
      ],
    );
  }

}
