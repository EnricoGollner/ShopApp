import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/core/components/custom_alert_dialog.dart';
import 'package:shop/core/utils/app_routes.dart';
import 'package:shop/core/enums/filter_options.dart';
import 'package:shop/core/components/app_drawer.dart';
import 'package:shop/store/viewModel/product/product_view_model.dart';
import 'package:shop/store/views/components/product_grid.dart';

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<ProductViewModel>(context, listen: false).loadProducts().catchError((error) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Store'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() => _showFavoriteOnly = selectedValue == FilterOptions.favorite);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('All'),
              ),
            ],
          ),
          Consumer<CartViewModel>(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.CART);
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
            builder: (_, cart, child) => Badge(
              offset: const Offset(-5, 4),
              label: Text('${cart.itemsCount}'),
              child: child,
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Visibility(
        visible: !_isLoading,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ProductGrid(favoriteOnly: _showFavoriteOnly),
      ),
    );
  }
}
