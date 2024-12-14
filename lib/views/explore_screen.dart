import 'package:e_commerce/viewmodels/explore_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreViewModel = Provider.of<ExploreViewModel>(context);

    if (exploreViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: exploreViewModel.categories.length,
      itemBuilder: (context, index) {
        final category = exploreViewModel.categories[index];
        return GestureDetector(
          onTap: () {
            // context.go('/categories/${category.id}');
            context.push(
              '/categories/${category.id}',
              extra: {'categoryName': category.name},
            );
          },
          child: Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(category.imageUrl!, fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    category.name!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
