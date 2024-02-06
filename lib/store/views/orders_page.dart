import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/orders/models/order_list.dart';
import 'package:shop/core/components/app_drawer.dart';
import 'package:shop/store/views/components/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderViewModel ordersProvider = Provider.of<OrderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: ordersProvider.itemsCount,
          itemBuilder: (context, index) => OrderCard(order: ordersProvider.items[index]),
        ),
      ),
    );
  }
}
