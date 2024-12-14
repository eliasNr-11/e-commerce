import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.network(
              'https://images.unsplash.com/photo-1630870111283-18e871e29400?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c3RyZWV0JTIwd2VhcnxlbnwwfHwwfHx8MA%3D%3D',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Theme.of(context).colorScheme.tertiary
                  ],
                  begin: Alignment.topCenter,
                  end: const Alignment(0, 0.2),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ECOMMERCE',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Your Apperance Shows Your Quality',
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w500,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Change the Quality of your Apperance With ECOMMERCE Now!',
                            style: TextStyle(
                                fontSize: 14.sp, color: Colors.grey[400]),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 60.h),
                          FilledButton(
                            onPressed: () {
                              context.go('/register');
                            },
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: Size.zero,
                            ),
                            child: Text(
                              'Sign Up with Email',
                              style: TextStyle(fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
