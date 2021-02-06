import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../global_state.dart';

class Bill_Screen extends StatefulWidget {
  @override
  _Bill_Screen_State createState() => _Bill_Screen_State();
}

class _Bill_Screen_State extends State<Bill_Screen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  Global_State _global_key = Global_State.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text(
          "Your Bill",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              initialUrl: 'http://icebeary.com/hope4cat/payment.php?email=' +
                  _global_key.user_list[0]["email"] +
                  '&mobile=' +
                  _global_key.user_list[0]["phone"] +
                  '&name=' +
                  _global_key.user_list[0]["name"] +
                  '&amount=' +
                  _global_key.value +
                  '&catid=' +
                  _global_key.catid,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          )
        ],
      ),
    );
  }
}
