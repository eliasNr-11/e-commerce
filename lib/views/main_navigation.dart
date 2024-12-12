import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    final List<String> routes = [
      '/home',
      '/explore',
      '/cart',
      '/profile',
    ];

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: homeViewModel.selectedTab,
        onDestinationSelected: (index) {
          homeViewModel.updateSelectedTab(index);
          context.go(routes[index]);
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}