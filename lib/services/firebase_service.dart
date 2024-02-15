import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Map<String, dynamic> productData) async {
    try {
      await _firestore.collection('products').add(productData);
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // Add other Firebase-related methods here...
}
