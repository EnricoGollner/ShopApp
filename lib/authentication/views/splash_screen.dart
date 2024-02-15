import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/authentication/viewModels/auth_view_model.dart';
import 'package:shop/authentication/views/authentication_screen.dart';
import 'package:shop/store/views/products_overview_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthViewModel authProvider = Provider.of<AuthViewModel>(context);

    return FutureBuilder(
      future: authProvider.tryAutoLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Error ocurred!'),
          );
        } else {
          return authProvider.isAuth
              ? const ProductsOverviewScreen()
              : const AuthenticationScreen();
        }
      },
    );
  }
}
