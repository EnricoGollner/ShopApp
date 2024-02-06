import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/core/utils/formatters.dart';
import 'package:shop/orders/models/order_list.dart';
import 'package:shop/cart/views/components/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartViewModel cartProvider = Provider.of<CartViewModel>(context);
    final items = cartProvider.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        side: BorderSide.none,
                        label: Text(
                          Formatters.doubleToCurrency(cartProvider.totalAmount),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineSmall
                                  ?.color),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderViewModel>(context, listen: false).addOrder(cartProvider);
                      cartProvider.clear();
                    },
                    child: Text(
                      'COMPRAR',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => CartItemCard(cartItem: items[index]),
            ),
          ),
        ],
      ),
    );
  }
}
