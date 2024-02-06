import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/core/components/custom_snack_bar.dart';
import 'package:shop/core/utils/app_routes.dart';
import 'package:shop/store/models/product.dart';

class ProductGridItemCard extends StatelessWidget {
  const ProductGridItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Product productProvider = Provider.of<Product>(context);
    final CartViewModel cartProvider = Provider.of<CartViewModel>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (_, product, __) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                product.toggleFavorite();
                showSnackBar(
                  context,
                  const BoxSnackBar.success(message:'Product added successfully to the favorite products list!'),
                );
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              cartProvider.addItem(productProvider);
              showSnackBar(
                context,
                BoxSnackBar.success(
                  message: 'Product added successfully to the cart',
                  actionLabel: 'Undo',
                  action: () => cartProvider.removeSingleItem(productProvider.id),
                ),
              );
            },
          ),
          title: Text(productProvider.title),
        ),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.PRODUCT_DETAIL,
            arguments: productProvider,
          ),
          child: Image.network(
            productProvider.urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
