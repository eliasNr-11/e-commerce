import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:flutter/material.dart';

class CategoryItemsViewModel extends ChangeNotifier {
  final ProductService _productService;
  List<Product> _products = [];
  bool _isLoading = true;

  CategoryItemsViewModel(this._productService);

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts(String categoryId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _products = await _productService.fetchProductsByCategory(categoryId);
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}