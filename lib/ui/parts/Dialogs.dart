import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dialogs {
  final BuildContext context;

  Dialogs({this.context});

  Future<void> showLoadingDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("お待ちください....", style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]
              )
          );
        });
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('エラー'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<bool> showExitDialog() {
    return showDialog(context: context,
      builder: (context) => new AlertDialog(
        title: new Text('確認'),
        content: new Text('アプリを終了します。よろしいですか？'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('いいえ'),
          ),
          new FlatButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('はい'),
          ),
        ],
      ),
    );
  }

  void closeDialog() {
    Navigator.pop(context);
  }

}