import 'package:flutter/material.dart';
import 'package:shop/core/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Welcome, User!'),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Store'),
            onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.HOME),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.ORDERS),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Products Management'),
            onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.PRODUCTS_MANAGEMENT),
          ),
        ],
      ),
    );
  }
}
