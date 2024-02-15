import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shop/authentication/viewModels/auth_view_model.dart';
import 'package:shop/authentication/views/authentication_screen.dart';
import 'package:shop/authentication/views/splash_screen.dart';
import 'package:shop/cart/viewModel/cart_view_model.dart';
import 'package:shop/core/theme/styles.dart';
import 'package:shop/core/utils/app_routes.dart';
import 'package:shop/cart/views/cart_screen.dart';
import 'package:shop/orders/models/order.dart';
import 'package:shop/orders/viewModel/order_view_model.dart';
import 'package:shop/store/models/product.dart';
import 'package:shop/store/viewModel/product_view_model.dart';
import 'package:shop/orders/views/orders_screen.dart';
import 'package:shop/store/views/product_detail_screen.dart';
import 'package:shop/store/views/products_management/product_add_screen.dart';
import 'package:shop/store/views/products_management/products_management_page.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

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
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProxyProvider<AuthViewModel, ProductViewModel>(
          // A proxy provider is a provider that depends on another provider
          create: (context) => ProductViewModel(),
          update: (context, auth, previousProductViewModel) {
            return ProductViewModel(
              auth.token ?? '',
              auth.userId ?? '',
              previousProductViewModel?.items ?? List<Product>.empty(),
            );
          },
        ),
        ChangeNotifierProxyProvider<AuthViewModel, OrderViewModel>(
          create: (context) => OrderViewModel(),
          update: (context, auth, previous) => OrderViewModel(auth.token ?? '', auth.userId ?? '', previous?.items ?? List<Order>.empty()),
        ),
        ChangeNotifierProvider(
          create: (context) => CartViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: Styles.setMaterial3Theme(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (_) => const SplashScreen(),
          AppRoutes.AUTHENTICATION: (_) => const AuthenticationScreen(),
          AppRoutes.PRODUCT_DETAIL: (_) => const ProductDetailScreen(),
          AppRoutes.CART: (_) => const CartScreen(),
          AppRoutes.ORDERS: (_) => const OrdersScreen(),
          AppRoutes.PRODUCTS_MANAGEMENT: (_) => const ProductsManagementScreen(),
          AppRoutes.PRODUCTS_ADD: (_) => const ProductAddScreen(),
        },
      ),
    );
  }
}
