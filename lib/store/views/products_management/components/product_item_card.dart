import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  final String urlImage;
  final String title;
  final void Function() onEdit;
  final Future<void> Function() onDelete;

  const ProductItemCard({
    super.key,
    required this.urlImage,
    required this.title,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(urlImage),
      ),
      title: Text(title),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: Row(
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
