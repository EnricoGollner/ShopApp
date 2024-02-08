import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/components/custom_alert_dialog.dart';
import 'package:shop/orders/viewModel/order_view_model.dart';
import 'package:shop/core/components/app_drawer.dart';
import 'package:shop/store/views/components/order_card.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrderViewModel>(context, listen: false)
            .loadOrders()
            .catchError((error) {
          showDialog(
            context: context,
            builder: (context) => CustomAlertDialog(
                title: 'Error ocurred', contentText: 'Error: $error'),
          );
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Column(
              children: [
                const Text('Error ocurred searching for items!'),
                Text('${snapshot.error}'),
              ],
            ),);
          }

          return Consumer<OrderViewModel>(
            builder: (_, ordersProvider, __) {
              return Visibility(
                visible: ordersProvider.items.isEmpty,
                replacement: const Center(child: Text('No products registered yet!'),),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListView.builder(
                    itemCount: ordersProvider.itemsCount,
                    itemBuilder: (context, index) => OrderCard(order: ordersProvider.items[index]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
