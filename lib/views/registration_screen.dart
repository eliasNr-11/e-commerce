import 'package:e_commerce/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
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
                'Sign Up',
                style: TextStyle(fontSize: 42.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.h),
              Text(
                'Create your account',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 60.h),
              Text(
                'First Name',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your first name',
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
              SizedBox(height: 10.h),
              Text(
                'Last Name',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your last name',
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
              SizedBox(height: 10.h),
              Text(
                'Email',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
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
              SizedBox(height: 10.h),
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
                  name: 'Register',
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
                ),
              if (authViewModel.errorMessage != null)
                Text(authViewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red)),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Text(
                      'Login',
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
