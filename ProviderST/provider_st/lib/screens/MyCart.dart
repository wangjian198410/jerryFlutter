import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerst/models/CartModel.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.teal.shade50,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);

    return ListView.builder(
      itemCount: cart.items.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        title: Text(
          cart.items[index].name,
        ),
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
                builder: (context, cart, child) =>
                    Text('\$${cart.totalPrice}')),
            SizedBox(width: 24),
            FlatButton(
              onPressed: () {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Buying not supported yet.')));
              },
              color: Colors.white,
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}