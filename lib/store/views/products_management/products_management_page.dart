import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/utils/app_routes.dart';
import 'package:shop/core/components/app_drawer.dart';
import 'package:shop/store/viewModel/product/product_view_model.dart';
import 'package:shop/store/views/products_management/components/product_item_card.dart';

class ProductsManagementPage extends StatelessWidget {
  const ProductsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.PRODUCTS_ADD),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProductViewModel>(
          builder: (context, productListProvider, child) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(color: Colors.grey, thickness: 1),
              itemCount: productListProvider.items.length,
              itemBuilder: (context, index) {
                final product = productListProvider.items[index];

                return ProductItemCard(
                  imageUrl: product.urlImage,
                  title: product.title,
                  onEdit: () => Navigator.pushNamed(
                      context, AppRoutes.PRODUCTS_ADD,
                      arguments: product),
                  onDelete: () async => await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text('Delete Product'),
                          content:
                              Text("Do you want to delete ${product.title}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes'),
                            ),
                          ],
                        );
                      }).then((value) {
                    if (value ?? false) {
                      productListProvider.deleteProduct(id: product.id);
                    }
                  }),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
