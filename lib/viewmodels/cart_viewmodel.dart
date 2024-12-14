import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartViewModel extends ChangeNotifier {
  final Box<CartItem> _cartBox = Hive.box<CartItem>('cartBox');
  List<CartItem> get cartItems => _cartBox.values.toList();
  List<CartItem> selectedItems = [];

  void addToCart(Product product, int quantity) {
    CartItem? existingItem;
    try {
      existingItem =
          _cartBox.values.firstWhere((item) => item.productId == product.id);
    } catch (e) {
      existingItem = null; // Item not found
    }

    if (existingItem != null) {
      existingItem.quantity += quantity;
      _cartBox.put(existingItem.productId, existingItem);
    } else {
      final newItem = CartItem(
        productId: product.id!,
        imageUrl: product.imageUrl!,
        quantity: quantity,
        price: product.price!,
        productName: product.name!,
      );
      _cartBox.put(newItem.productId, newItem);
    }

    notifyListeners();
  }

  void incrementItemQuantity(CartItem item) {
    item.quantity++;
    item.save();
    notifyListeners();
  }

  void decrementItemQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      item.save();
    } else {
      _cartBox.delete(item.key);
    }
    notifyListeners();
  }

  void toggleItemSelection(CartItem item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    notifyListeners();
  }

  void removeSelectedItems() {
    for (var item in selectedItems) {
      _cartBox.delete(item.key);
    }
    selectedItems.clear();
    notifyListeners();
  }

  double calculateTotalPrice() {
    return selectedItems
        .map((item) => item.price * item.quantity)
        .fold(0.0, (prev, curr) => prev + curr);
  }

  Future<void> placeOrder(List<CartItem> selectedItems,
      String selectedPaymentMethod, String deliveryAddress) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception("User not logged in");
      }

      final order = {
        'userId': userId,
        'paymentMethod': selectedPaymentMethod,
        'items': selectedItems.map((item) {
          return {
            'productId': item.productId,
            'name': item.productName,
            'quantity': item.quantity,
            'price': item.price,
            'imageUrl': item.imageUrl,
          };
        }).toList(),
        'totalPrice': calculateTotalPrice(),
        'deliveryAddress': deliveryAddress,
        'status': 'pending',
        'orderDate': DateTime.now(),
      };

      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
      await orderRef.set(order);

      removeSelectedItems();

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void clearSelectedItems() {
    for (var item in selectedItems) {
      _cartBox.delete(item.key);
    }
    selectedItems.clear();
    notifyListeners();
  }
}
