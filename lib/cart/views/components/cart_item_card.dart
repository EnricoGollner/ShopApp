import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/cart/models/cart_item.dart';
import 'package:shop/core/utils/formatters.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) => Provider.of<CartViewModel>(context, listen: false).removeItem(cartItem.productId),
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('Confirm'),
              content: const Text('Are you sure you want to remove this product from your cart?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Confirm'),
                )
              ],
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text(
                'Total: ${Formatters.doubleToCurrency(cartItem.price * cartItem.quantity)}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
