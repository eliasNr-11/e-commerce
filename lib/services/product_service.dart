import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/products_model.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Product>> fetchProducts() async {
    try {
      // Log the beginning of fetch
      print("Fetching products from Firestore...");
      
      QuerySnapshot snapshot = await _firestore.collection('products').get();

      // Check if data exists
      print("Number of products fetched: ${snapshot.docs.length}");

      // Debug individual documents
      snapshot.docs.forEach((doc) {
        print("Document Data: ${doc.data()}");
      });

      // Parse data into Product list
      return snapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error while fetching products: $e");
      throw Exception("Failed to fetch products: $e");
    }
  }

  Future<List<Product>> fetchProductsByCategory(String categoryId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      return snapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch products for category $categoryId: $e");
    }
  }
}