import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String selectedPaymentMethod = "credit_card";
  String deliveryAddress = "123 Main St, City, Country";  // Static address, can be dynamic if needed.

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final totalPrice = cartViewModel.calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Method Selection
            const Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text("Credit Card"),
              leading: Radio<String>(
                value: "credit_card",
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Debit Card"),
              leading: Radio<String>(
                value: "debit_card",
                groupValue: selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            // Delivery Address
            const Text(
              'Delivery Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              deliveryAddress,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Order Summary
            const Text(
              'Order Summary:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Total Price: \$${totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 20),
            // Place Order Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final goRouter = GoRouter.of(context);

                  // Call the place order method from ViewModel
                  await cartViewModel.placeOrder(
                    cartViewModel.selectedItems,
                    selectedPaymentMethod,
                    deliveryAddress,
                  );

                  // After placing the order, navigate back to the home page
                  goRouter.go('/home');
                },
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}