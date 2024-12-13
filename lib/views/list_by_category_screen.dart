import 'package:e_commerce/viewmodels/category_item_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';

class ListByCategoryPage extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const ListByCategoryPage({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryItemsViewModel(context.read<ProductService>())
        ..fetchProducts(categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
        ),
        body: Consumer<CategoryItemsViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.products.isEmpty) {
              return const Center(child: Text("No products found."));
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
                    subtitle: Text("\$${product.price!.toStringAsFixed(2)}"),
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
    );
  }
}
