import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen();

//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     final products = Provider.of<Products>(context, listen: false);
//     products.load();
//     Provider.of<Orders>(context, listen: false)
//         .load(Map.fromEntries(products.items.map((e) => MapEntry(e.id, e))))
//         .then((_) => setState(() => _isLoading = false));
//   }

  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context, listen: false);
    final Products products = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: orders.load(
            Map.fromEntries(products.items.map((e) => MapEntry(e.id, e)))),
        builder: (ctx, snapshot) =>
            ConnectionState.waiting == snapshot.connectionState
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: orders.size,
                    itemBuilder: (_, index) => OrderWidget(orders.items[index]),
                  ),
      ),
      // body: _isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : ListView.builder(
      //         itemCount: orders.size,
      //         itemBuilder: (_, index) => OrderWidget(orders.items[index]),
      //       ),
    );
  }
}
