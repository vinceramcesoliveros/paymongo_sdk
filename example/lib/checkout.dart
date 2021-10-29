import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: public_member_api_docs
class CheckoutPage extends StatefulWidget {
  // ignore: public_member_api_docs

  const CheckoutPage({required this.url, required this.returnUrl});
  // ignore: public_member_api_docs
  final String url;
  final String returnUrl;

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Completer<WebViewController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: WebView(
          onWebViewCreated: _controller.complete,
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          debuggingEnabled: kDebugMode,
          navigationDelegate: (request) async {
            if (request.url == widget.returnUrl) {
              Navigator.pop(context, widget.returnUrl);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) async {
            final dialog = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Something went wrong'),
                  content: Text('$error'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('close'),
                    )
                  ],
                );
              },
            );
            if (dialog) {
              Navigator.pop(context, false);
            }
          },
        ),
      )),
    );
  }
}
