import 'package:e_commerce/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
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

                  await authViewModel.register(
                    email: _emailController.text,
                    password: _passwordController.text,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                  );

                  if (!authViewModel.isError) {
                    goRouter.go('/');
                  }
                },
                child: const Text("Register"),
              ),
            if (authViewModel.errorMessage != null)
              Text(authViewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red)),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
