
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_api_sample/ui/widget_keys.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key key, @required this.urlString}) : super(key: key);
  final String urlString;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記事詳細'),
        leading: IconButton(
          key: Key(WidgetKey.KEY_WEB_APP_BAR_ICON_BUTTON),
          icon: const Icon(
            Icons.arrow_back,
            key: Key(WidgetKey.KEY_WEB_APP_BAR_ICON),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.urlString,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
      bottomNavigationBar: BottomAppBar(
        child: FutureBuilder<WebViewController>(
            future: _controller.future,
            builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
              final bool webViewReady = snapshot.connectionState == ConnectionState.done;
              final WebViewController snapshotData = snapshot.data;
              return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: !webViewReady ? null : () async {
                        if (await snapshotData.canGoBack()) {
                          await snapshotData.goBack();
                        } else {
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(content: Text("履歴がありません")),
                          );
                          return;
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: !webViewReady ? null : () async {
                        if (await snapshotData.canGoForward()) {
                          await snapshotData.goForward();
                        } else {
                          Scaffold.of(context).showSnackBar(
                            const SnackBar(content: Text("履歴がありません")),
                          );
                          return;
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.autorenew),
                      onPressed: !webViewReady ? null : () {
                        snapshotData.reload();
                      },
                    ),
                  ],
              );
            }
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}
