import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user
      User? user = userCredential.user;

      if (user != null) {
        // Update the user's displayName
        await user.updateDisplayName('$firstName $lastName');

        // Save additional details to Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          // print('${e.code}, ${e.message}');
          throw Exception("The email address is not valid.");
        case 'user-disabled':
          throw Exception("This user account has been disabled.");
        case 'user-not-found':
          throw Exception("No user found with this email.");
        case 'wrong-password':
          throw Exception("Incorrect password.");
        case 'email-already-in-use':
          throw Exception(
              "The email address is already in use by another account.");
        case 'operation-not-allowed':
          throw Exception(
              "Email/password accounts are not enabled in the Firebase project.");
        case 'weak-password':
          throw Exception("The provided password is not strong enough.");
        case 'too-many-requests':
          throw Exception(
              "Too many attempts to sign in, please try again later.");
        case 'network-request-failed':
          throw Exception("A network error occurred.");
        default:
          throw Exception("An unknown error occurred: ${e.message}");
      }
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw Exception("The email address is not valid.");
        case 'user-disabled':
          throw Exception("This user account has been disabled.");
        case 'user-not-found':
          throw Exception("No user found with this email.");
        case 'wrong-password':
          throw Exception("Incorrect password.");
        default:
          throw Exception("An unknown error occurred: ${e.message}");
      }
    }
  }

  // Check if a user is logged in
  User? get currentUser => _auth.currentUser;

  Future<void> logout() async {
    await _auth.signOut();
  }
}
