import 'package:e_commerce/viewmodels/auth_viewmodel.dart';
import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/viewmodels/profile_viewmodel.dart'; // ProfileViewModel
// import 'package:e_commerce/models/order_model.dart'
//     as order_model;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: profileViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  if (profileViewModel.user != null) ...[
                    Text(
                      'Full Name: ${profileViewModel.user?.displayName ?? 'N/A'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Email: ${profileViewModel.user?.email ?? 'N/A'}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                  // Logout Button
                  ElevatedButton(
                    onPressed: () async {
                      final goRouter = GoRouter.of(context);
                      final homeVM = Provider.of<HomeViewModel>(context, listen: false);
                      
                      await authViewModel.logout();
                      homeVM.updateSelectedTab(0);
                      goRouter.go('/login');
                    },
                    child: const Text("Logout"),
                  ),
                  const SizedBox(height: 30),
                  // Order History
                  const Text(
                    'Order History:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: profileViewModel.orders.length,
                      itemBuilder: (context, index) {
                        final order = profileViewModel.orders[index];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Order Images in a Stack
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
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: Image.network(
                                              item.imageUrl!,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
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
                                const SizedBox(height: 10),
                                // Order Date and Total Price
                                Text(
                                  'Order Date: ${order.orderDate!.toDate()}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Total Price: \$${order.totalPrice!.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
