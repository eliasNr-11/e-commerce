import 'package:e_commerce/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Profile'),
            const SizedBox(height: 20),
            FilledButton(
                onPressed: () async {
                  final goRouter = GoRouter.of(context);

                  await authViewModel.logout();
                  goRouter.go('/login');
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
