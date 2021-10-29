import 'package:example/shoes.dart';
import 'package:flutter/material.dart';

class ShoeCard extends StatelessWidget {
  const ShoeCard({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
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
      ),
    );
  }
}
