import 'package:flutter/material.dart';
import 'package:shop/core/utils/formatters.dart';
import 'package:shop/orders/models/order.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(Formatters.doubleToCurrency(widget.order.total)),
            subtitle:
                Text(Formatters.dateTimeToString(date: widget.order.date)),
            trailing: IconButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                icon:  Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          Visibility(
            visible: _expanded,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: (widget.order.products.length * 25) + 10,
              child: ListView(
                children: widget.order.products
                    .map(
                      (product) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${product.quantity}x ${Formatters.doubleToCurrency(product.price)}',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
