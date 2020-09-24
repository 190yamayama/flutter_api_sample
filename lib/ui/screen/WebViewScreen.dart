
import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/WidgetKey.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print',
      onMessageReceived: (JavascriptMessage message) {
        print(message.message);
      }),
].toSet();


class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key key, @required this.urlString}) : super(key: key);
  final String urlString;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  @override
  Widget build(BuildContext context) {
    var widget = context.widget as WebViewScreen;
    return WebViewScreenPage(urlString: widget.urlString);
  }

}

class WebViewScreenPage extends StatelessWidget {
  WebViewScreenPage({Key key, @required this.urlString}) : super(key: key);
  final String urlString;
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: Key(WidgetKey.KEY_WEB_WEB_VIEW),
      url: urlString,
      javascriptChannels: jsChannels,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          key: Key(WidgetKey.KEY_WEB_APP_BAR_ICON_BUTTON),
          icon: const Icon(
            Icons.arrow_back,
            key: Key(WidgetKey.KEY_WEB_APP_BAR_ICON),
          ),
          onPressed: () => Navigator.pop(context),
        )
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: Colors.white60,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),
            IconButton(
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
          ],
        ),
      ),
    );
  }
}