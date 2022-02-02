import 'package:example/shoe_card.dart';
import 'package:flutter/material.dart';

import 'event_handler.dart';
import 'payments/scaffold.dart';
import 'shoes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

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

  double get _totalAmount => _cart.fold(0, (prev, curr) => prev + curr.amount);
  final List<Shoe> _cart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap to pay'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text("Payments"),
              onTap: () {
                Navigator.push(context,
                    PageRouteBuilder(pageBuilder: (context, _, __) {
                  return PaymentScaffold();
                }));
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return GridView.builder(
          itemCount: _shoes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
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
              child: ShoeCard(shoe: shoe),
            );
          },
        );
      }),
      floatingActionButton: _totalAmount > 100
          ? FloatingActionButton.extended(
              onPressed: () async {
                await showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return PaymentOptionList(cart: _cart);
                    });
              },
              label: Text('Single Payment(${_cart.length})'),
              icon: const Icon(Icons.credit_card),
            )
          : null,
    );
  }
}

class PaymentOptionList extends StatefulWidget {
  const PaymentOptionList({Key? key, required this.cart}) : super(key: key);
  final List<Shoe> cart;
  @override
  State<PaymentOptionList> createState() => _PaymentOptionListState();
}

class _PaymentOptionListState extends State<PaymentOptionList>
    with PaymongoEventHandler {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text("GCash Payment"),
            onTap: () async {
              await gcashPayment(widget.cart);
            },
          ),
          ListTile(
            title: Text("Credit/Debit Payment"),
            onTap: () async {
              await cardPayment(widget.cart);
            },
          ),
          ListTile(
            title: Text('Grab Pay'),
            onTap: () async {
              await grabPayment(widget.cart);
            },
          ),
          ListTile(
            title: Text("PayMaya Payment"),
            onTap: () async {
              await paymayaPayment(widget.cart);
            },
          ),
        ],
      ),
    );
  }
}
