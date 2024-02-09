import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/orders/viewModel/order_view_model.dart';

class BuyButton extends StatefulWidget {
  const BuyButton({
    super.key,
    required this.cartProvider,
  });

  final CartViewModel cartProvider;

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const CircularProgressIndicator() : TextButton(
      onPressed: widget.cartProvider.items.isEmpty ? null : () async {
        setState(() => _isLoading = true);
        await Provider.of<OrderViewModel>(context, listen: false).addOrder(widget.cartProvider);
        widget.cartProvider.clear();
        setState(() => _isLoading = false);
      },
      child: Text(
        'COMPRAR',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
