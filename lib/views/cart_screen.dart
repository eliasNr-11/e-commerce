import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = context.watch<CartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartViewModel.cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartViewModel.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartViewModel.cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Image.network(
                            cartItem.imageUrl,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(cartItem.productName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price: \$${cartItem.price.toStringAsFixed(2)}',
                              ),
                              Text(
                                'Quantity: ${cartItem.quantity}',
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: cartViewModel.selectedItems
                                    .contains(cartItem),
                                onChanged: (value) {
                                  cartViewModel.toggleItemSelection(cartItem);
                                },
                              ),
                              IconButton(
                                onPressed: () =>
                                    cartViewModel.decrementItemQuantity(
                                        cartItem),
                                icon: const Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () =>
                                    cartViewModel.incrementItemQuantity(
                                        cartItem),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: \$${cartViewModel.calculateTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: cartViewModel.selectedItems.isEmpty
                            ? null
                            : () {
                                // Navigate to order page
                                context.push('/place-order');
                              },
                        child: const Text('Place Order'),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: cartViewModel.selectedItems.isEmpty
                            ? null
                            : () {
                                cartViewModel.removeSelectedItems();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Remove Selected'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}