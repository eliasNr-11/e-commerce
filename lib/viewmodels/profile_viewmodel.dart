import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/order_model.dart' as order_model; 

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  List<order_model.Order> _orders = [];
  List<order_model.Order> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileViewModel() {
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch user data
      _user = _auth.currentUser;

      // Fetch order history for the user
      if (_user != null) {
        final orderSnapshot = await _firestore
            .collection('orders')
            .where('userId', isEqualTo: _user!.uid)
            .orderBy('orderDate', descending: true)
            .get();

        _orders = orderSnapshot.docs
            .map((doc) => order_model.Order.fromJson(doc.data()))
            .toList();
      }
    } catch (e) {
      // Handle errors (you can show error messages if needed)
      print(e);
    }

    _isLoading = false;
    notifyListeners();
  }
}