import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/store/models/product.dart';
import 'package:shop/store/viewModel/product_view_model.dart';
import 'package:shop/store/views/components/product_grid_item_card.dart';

class ProductGrid extends StatelessWidget {
  final bool favoriteOnly;

  const ProductGrid({super.key, required this.favoriteOnly});

  @override
  Widget build(BuildContext context) {
    final ProductViewModel provider = Provider.of<ProductViewModel>(context);
    final List<Product> loadedProducts = favoriteOnly ? provider.favoriteItems : provider.items;

    return RefreshIndicator(
      onRefresh: () async => await Provider.of<ProductViewModel>(context, listen: false).loadProducts(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: loadedProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: loadedProducts[index],
            child: const ProductGridItemCard(),
          ),
        ),
      ),
    );
  }
}
