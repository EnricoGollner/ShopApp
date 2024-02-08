import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/core/theme/styles.dart';
import 'package:shop/core/utils/app_routes.dart';
import 'package:shop/cart/views/cart_page.dart';
import 'package:shop/orders/viewModel/order_view_model.dart';
import 'package:shop/store/viewModel/product_view_model.dart';
import 'package:shop/orders/views/orders_page.dart';
import 'package:shop/store/views/product_detail_page.dart';
import 'package:shop/store/views/products_management/product_add_page.dart';
import 'package:shop/store/views/products_management/products_management_page.dart';
import 'package:shop/store/views/products_overview_page.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        ChangeNotifierProvider(create: (context) => OrderViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: Styles.setMaterial3Theme(),
        routes: {
          AppRoutes.HOME: (_) => const ProductsOverviewPage(),
          AppRoutes.PRODUCT_DETAIL: (_) => const ProductDetailPage(),
          AppRoutes.CART: (_) => const CartPage(),
          AppRoutes.ORDERS: (_) => const OrdersPage(),
          AppRoutes.PRODUCTS_MANAGEMENT: (_) => const ProductsManagementPage(),
          AppRoutes.PRODUCTS_ADD: (_) => const ProductAddPage(),
        },
      ),
    );
  }
}
