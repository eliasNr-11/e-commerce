import 'package:e_commerce/views/cart_screen.dart';
import 'package:e_commerce/views/explore_screen.dart';
import 'package:e_commerce/views/home_screen.dart';
import 'package:e_commerce/views/login_screen.dart';
import 'package:e_commerce/views/main_navigation.dart';
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
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    // GoRoute(
    //   path: '/home',
    //   builder: (BuildContext context, GoRouterState state) => const HomePage(),
    // ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainNavigation(child: child,);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/explore',
          pageBuilder: (context, state) => const MaterialPage(child: ExploreScreen()),
        ),
        GoRoute(
          path: '/cart',
          pageBuilder: (context, state) => const MaterialPage(child: CartScreen()),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const MaterialPage(child: ProfileScreen()),
        ),
      ],
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) => RegistrationScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) => LoginScreen(),
    ),
  ],
);
