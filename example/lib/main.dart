import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'shoes.dart';

const payMongoKey = String.fromEnvironment('apiKey', defaultValue: '');
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

/// Your PayMaya Example App.
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Shoe> _shoes = List.generate(5, (index) {
    return Shoe(
      amount: 100 * index,
      currency: 'PHP',
      name: 'Shoe #$index',
      description: 'A smol shoe size of S-$index',
    );
  });

  @override
  void initState() {
    super.initState();
  }

  final List<Shoe> _cart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Paymaya Shoepping app'),
        ),
        body: GridView.builder(
          itemCount: _shoes.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250),
          itemBuilder: (context, index) {
            final shoe = _shoes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!_cart.contains(shoe)) {
                    _cart.add(shoe);
                  }
                });
              },
              child: _ShoeCard(shoe: shoe),
            );
          },
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton.extended(
              onPressed: () async {
                final _amount = _cart.fold<num>(0,
                    (previousValue, element) => previousValue + element.amount);
                final sdk = PayMongoSDK(payMongoKey);
                final url = 'google.com';
                final _source = Source(
                  type: "gcash",
                  amount: _amount.toDouble(),
                  currency: 'PHP',
                  redirect: Redirect(
                    success: "https://$url/success",
                    failed: "https://$url/failed",
                  ),
                  billing: PayMongoBilling(
                    address: PayMongoAddress(
                      city: "Cotabato City",
                      country: "PH",
                      state: "Mindanao",
                      line1: "Secret Address",
                    ),
                    name: "Anonymous",
                    email: "test@gmail.com",
                    phone: "09123456002",
                  ),
                );
                final result = await sdk.createSource(_source);
                final response = await Navigator.push<String>(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CheckoutPage(
                      url: result.attributes.redirect.checkoutUrl,
                      returnUrl: result.attributes.redirect.success,
                    ),
                  ),
                );
                debugPrint("==============================");
                debugPrint("||$response||");
                debugPrint("==============================");
              },
              label: Text('Single Payment(${_cart?.length})'),
              icon: const Icon(Icons.credit_card),
            ),
          ],
        ));
  }
}

class _ShoeCard extends StatelessWidget {
  const _ShoeCard({
    Key key,
    @required this.shoe,
  }) : super(key: key);

  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.red[100],
            height: 100,
          ),
          ListTile(
            title: Text(shoe.name),
            subtitle: Text(shoe.description),
            trailing: Text(
              '${shoe.currency} ${shoe.amount.toStringAsFixed(2)}',
            ),
          )
        ],
      ),
    );
  }
}

// ignore: public_member_api_docs
class CheckoutPage extends StatefulWidget {
  // ignore: public_member_api_docs
  const CheckoutPage({this.url, this.returnUrl});
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
