import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedTab = 0;

  final ProductService _productService;
  List<Product> _allProducts = [];
  bool _isLoading = true;
  String? _errorMessage;

  List<Product> _filteredProducts = [];
  bool _showDiscounted = false;

  HomeViewModel(this._productService){
    fetchProducts();
  }

  void updateSelectedTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get selectedTab => _selectedTab;
  bool get showDiscounted => _showDiscounted;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _allProducts = await _productService.fetchProducts();
      _filteredProducts = List.from(_allProducts);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleFilter() {
    _showDiscounted = !_showDiscounted;
    if (_showDiscounted) {
      _filteredProducts = _allProducts.where((product) => product.discount! > 0).toList();
    } else {
      _filteredProducts = _allProducts;
    }

    notifyListeners();
  }
}