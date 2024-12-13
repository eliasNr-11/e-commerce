import 'package:e_commerce/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          // Filter Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeViewModel>().toggleFilter();
                  },
                  child: Consumer<HomeViewModel>(
                    builder: (context, viewModel, _) {
                      return Text(
                        viewModel.showDiscounted
                            ? 'Show All Items'
                            : 'Show Discounted',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: Consumer<HomeViewModel>(
              builder: (context, viewModel, _) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (viewModel.products.isEmpty) {
                  return const Center(child: Text('No products available.'));
                }

                return ListView.builder(
                  itemCount: viewModel.products.length,
                  itemBuilder: (context, index) {
                    final product = viewModel.products[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(
                          product.imageUrl!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.name!),
                        subtitle: product.discount! > 0
                            ? Text(
                                "Discounted: \$${(product.price! - product.discount!).toStringAsFixed(2)}",
                                style: const TextStyle(color: Colors.green),
                              )
                            : Text("\$${product.price!.toStringAsFixed(2)}"),
                        onTap: () {
                          context.push('/detail/${product.id}', extra: product);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
