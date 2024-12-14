import 'package:e_commerce/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/viewmodels/profile_viewmodel.dart'; // ProfileViewModel

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: const CustomAppBar(title: 'PROFILE', back: false, bottom: false),
      body: profileViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (profileViewModel.user != null) ...[
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        (() {
                          String displayName =
                              profileViewModel.user!.displayName!;
                          List<String> words = displayName.trim().split(' ');
                          return words
                              .map((word) => word[0].toUpperCase())
                              .join();
                        })(),
                        style: TextStyle(
                          fontSize: 42.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      profileViewModel.user?.displayName ?? 'N/A',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      profileViewModel.user?.email ?? 'N/A',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(height: 20.h),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          name: 'Logout',
                          onPressed: () async {
                            final goRouter = GoRouter.of(context);
                            final homeVM = Provider.of<HomeViewModel>(context,
                                listen: false);

                            await authViewModel.logout();
                            homeVM.updateSelectedTab(0);
                            goRouter.go('/onboarding');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    'Order History',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: profileViewModel.orders.length,
                      itemBuilder: (context, index) {
                        final order = profileViewModel.orders[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Row(
                                  children: List.generate(
                                    order.items!.length > 3
                                        ? 3
                                        : order.items!.length,
                                    (index) {
                                      final item = order.items![index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: Image.network(
                                            item.imageUrl!,
                                            width: 112.r,
                                            height: 100.r,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (order.items!.length > 3) ...[
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
                                        child: Text(
                                          '+${order.items!.length - 3}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Order Date',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              DateFormat('MMM dd, yyyy hh:mm a')
                                  .format(order.orderDate!.toDate()),
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Total Price',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              ' \$${order.totalPrice!.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 30.h),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
