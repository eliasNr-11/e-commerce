import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserSession();
    });
  }

  void _checkUserSession() {
    final goRouter = GoRouter.of(context);

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    authViewModel.checkSession();

    Future.delayed(const Duration(milliseconds: 1), () {
      if (authViewModel.isLoggedIn) {
        goRouter.go('/home');
      } else {
        goRouter.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}