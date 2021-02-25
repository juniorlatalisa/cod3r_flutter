import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
    );
  }
}
