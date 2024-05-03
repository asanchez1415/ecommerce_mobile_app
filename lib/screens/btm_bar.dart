import 'package:ecommerce_mobile_app/routes/app_routes.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My profile",
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildTabScreen(0, 'HomeScreen'),
          _buildTabScreen(1, 'CategoriesScreen'),
          _buildTabScreen(2, 'CartScreen'),
          _buildTabScreen(3, 'UserScreen')
        ],
      ),
    );
  }

  Widget _buildTabScreen(int tabIndex, String routeName) {
    return Offstage(
      offstage: _selectedTab != tabIndex,
      child: Container(
        color: Colors.black, // Set main screen background color to black
        child: Navigator(
          key: GlobalKey(),
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => AppRoutes.routes[routeName]!(context),
            );
          },
        ),
      ),
    );
  }
}
