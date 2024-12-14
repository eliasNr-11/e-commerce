import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/views/cart_screen.dart';
import 'package:e_commerce/views/detail_screen.dart';
import 'package:e_commerce/views/explore_screen.dart';
import 'package:e_commerce/views/home_screen.dart';
import 'package:e_commerce/views/list_by_category_screen.dart';
import 'package:e_commerce/views/login_screen.dart';
import 'package:e_commerce/views/main_navigation.dart';
import 'package:e_commerce/views/onboarding_screen.dart';
import 'package:e_commerce/views/place_order_screen.dart';
import 'package:e_commerce/views/profile_screen.dart';
import 'package:e_commerce/views/registration_screen.dart';
import 'package:e_commerce/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

bool isLoggedIn = false;
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    // GoRoute(
    //   path: '/home',
    //   builder: (BuildContext context, GoRouterState state) => const HomePage(),
    // ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainNavigation(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ExploreScreen()),
        ),
        GoRoute(
          path: '/cart',
          pageBuilder: (context, state) =>
              const MaterialPage(child: CartScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ProfileScreen()),
        ),
      ],
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) =>
          RegistrationScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => LoginScreen(),
    ),
    GoRoute(
      path: '/categories/:categoryId',
      builder: (context, state) {
        final categoryId = state.pathParameters['categoryId']!;
        final categoryName = state.extra as Map<String, String?>;
        return ListByCategoryPage(
          categoryId: categoryId,
          categoryName: categoryName['categoryName']!,
        );
      },
    ),
    GoRoute(
      path: '/detail/:id',
      builder: (context, state) {
        // Retrieve the product passed via 'extra'
        final product = state.extra as Product;
        return DetailScreen(product: product);
      },
    ),
    GoRoute(
      path: '/place-order',
      builder: (BuildContext context, GoRouterState state) => const PlaceOrderScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (BuildContext context, GoRouterState state) => const OnboardingScreen(),
    ),
  ],
);
