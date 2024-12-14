import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Welcome Back',
                style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.h),
              Text(
                'Enter your credentials for login',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 60.h),
              Text(
                'Email',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                  hintStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                  // helperText: helperText,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onTertiary,
                        width: 1),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 0.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 1),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Password',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onTertiary,
                        width: 1),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 0.5),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 1),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.w),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 18.r,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 80.h),
              if (authViewModel.isLoading)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                )
              else
                MainButton(
                  name: 'Login',
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
                ),
              if (authViewModel.errorMessage != null)
                Text(authViewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red)),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () => context.go('/register'),
                    child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
