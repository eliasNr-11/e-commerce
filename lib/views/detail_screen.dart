import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Center(
                child: Image.network(
                  product.imageUrl!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // Product Name
              Text(
                product.name!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Product Price
              Text(
                product.discount != null
                    ? "Discounted Price: \$${product.discount!.toStringAsFixed(2)}"
                    : "Price: \$${product.price!.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
              if (product.discount != null)
                Text(
                  "Original Price: \$${product.price!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const SizedBox(height: 16),
              // Product Description
              Text(
                product.description!,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              // Add to Cart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showAddToCartModal(context, product);
                  },
                  child: const Text("Add to Cart"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddToCartModal(BuildContext context, Product product) {
    int quantity = 1;
    final price = product.discount ?? product.price!;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name!,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Quantity Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(quantity.toString(), style: const TextStyle(fontSize: 18)),
                      IconButton(
                        onPressed: () {
                          setState(() => quantity++);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Total Price
                  Text(
                    "Total Price: \$${(price * quantity).toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Add to Cart Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartViewModel>().addToCart(product, quantity);
                        Navigator.pop(context);
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}