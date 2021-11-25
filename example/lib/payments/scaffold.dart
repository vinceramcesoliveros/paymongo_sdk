import 'package:flutter/material.dart';
import 'package:paymongo_sdk/paymongo_sdk.dart';

import '../event_handler.dart';

class PaymentScaffold extends StatelessWidget {
  const PaymentScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _PaymentListView(),
    );
  }
}

class _PaymentListView extends StatefulWidget {
  const _PaymentListView({Key? key}) : super(key: key);

  @override
  __PaymentListViewState createState() => __PaymentListViewState();
}

class __PaymentListViewState extends State<_PaymentListView>
    with PaymongoEventHandler {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaymentListAllResponse>(
      future: secretClient.instance.payment
          .listAll(PaymentListQueryParams(limit: 100)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data?.data ?? [];
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final payment = items[index];
                return ExpansionTile(
                  title: Text("${payment?.attributes?.billing?.name}"),
                  subtitle:
                      Text("${payment?.attributes?.billing?.address.city}"),
                  children: [Text("${payment?.attributes}")],
                );
              });
        }

        return Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }
}
