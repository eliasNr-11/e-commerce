import 'package:e_commerce/models/categories_model.dart';
import 'package:flutter/material.dart';
import '../services/category_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final CategoryService _categoryService;
  List<Category> _categories = [];
  bool _isLoading = true;

  ExploreViewModel(this._categoryService) {
    fetchCategories();
  }

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();

      _categories = await _categoryService.fetchCategories();
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}