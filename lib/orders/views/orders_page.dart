import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/components/custom_alert_dialog.dart';
import 'package:shop/orders/viewModel/order_view_model.dart';
import 'package:shop/core/components/app_drawer.dart';
import 'package:shop/store/views/components/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<OrderViewModel>(context, listen: false).loadOrders().catchError((error) {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(title: 'Error ocurred', contentText: 'Error: $error'),
        );
      });
      setState(() => _isLoading = false);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final OrderViewModel ordersProvider = Provider.of<OrderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      drawer: const AppDrawer(),
      body: Visibility(
        visible: !_isLoading,
        replacement: const Center(child: CircularProgressIndicator(),),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView.builder(
            itemCount: ordersProvider.itemsCount,
            itemBuilder: (context, index) => OrderCard(order: ordersProvider.items[index]),
          ),
        ),
      ),
    );
  }
}
