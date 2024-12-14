import 'package:e_commerce/viewmodels/category_item_viewmodel.dart';
import 'package:e_commerce/views/widgets/custom_appbar.dart';
import 'package:e_commerce/views/widgets/home_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        appBar: CustomAppBar(title: categoryName, back: true),
        body: Consumer<CategoryItemsViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return Center(
                child: SizedBox(
                  height: 60.h,
                  width: 60.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.w,
                  ),
                ),
              );
            }

            if (viewModel.products.isEmpty) {
              return const Center(child: Text("No products found."));
            }

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: MasonryGridView.count(
                // physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: viewModel.products.length,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemBuilder: (context, index) {
                  final product = viewModel.products[index];
                  return HomeProduct(
                    product: product,
                    onPressed: () {
                      context.push('/detail/${product.id}', extra: product);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
