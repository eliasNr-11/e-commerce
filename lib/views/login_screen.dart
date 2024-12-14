import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (authViewModel.isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: () async {
                  final goRouter = GoRouter.of(context);

                  await authViewModel.login(
                    _emailController.text,
                    _passwordController.text,
                  );

                  if (!authViewModel.isError) {
                    goRouter.go('/');
                  }
                },
                child: const Text("Login"),
              ),
            if (authViewModel.errorMessage != null)
              Text(authViewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red)),
            TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
