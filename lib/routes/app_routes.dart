import 'package:flutter/material.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'LoginScreen';
  static Map<String, Widget Function(BuildContext)> routes = {
    'LoginScreen': (BuildContext context) => const LoginScreen(),
    'BottomBar': (BuildContext context) => const BottomBar(),
    'HomeScreen': (BuildContext context) => const HomeScreen(),
    'CartScreen': (BuildContext context) => const CartScreen(),
    'CategoriesScreen': (BuildContext context) => CategoriesScreen(),
    'UserScreen': (BuildContext context) => const UserScreen(),
    'ProductsScreen': (BuildContext context) => const ProductsScreen(),
    'RegisterScreen': (BuildContext context) => const RegisterScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
