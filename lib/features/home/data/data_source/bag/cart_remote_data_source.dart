import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/data/models/bag/cart_item_model.dart';
import 'package:dokan/features/home/domain/entities/bag/cart_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class CartRemoteDataSource {
  Stream<List<CartItemModel>> getCartItems();
  Future<void> updateQuantity(String productId, int quantity);
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String productId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CartRemoteDataSourceImpl({required this.firestore, required this.auth});

  @override
  Stream<List<CartItemModel>> getCartItems() {
    final user = auth.currentUser!.uid;
    return firestore
        .collection("users")
        .doc(user)
        .collection("cart")
        .snapshots()
        .map((snapshot) {


          return snapshot.docs
              .map((e) => CartItemModel.fromJson(e.data()))
              .toList();
        });
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final user = auth.currentUser!.uid;
    final docRef = firestore
        .collection('users')
        .doc(user)
        .collection('cart')
        .doc(item.productId);

    final doc = await docRef.get();

    if (doc.exists) {
      /// 🔥 If item exists → increase quantity
      final currentQty = doc['quantity'];
      await docRef.update({
        "quantity": currentQty + item.quantity,
      });
    } else {
      /// 🔥 New item
      await docRef.set({
        "productId": item.productId,
        "name": item.name,
        "image": item.image,
        "price": item.price,
        "quantity": item.quantity,
        "discount": item.discount,
      });
    }

  }

  @override
  Future<void> removeFromCart(String productId) async {
    final userId = auth.currentUser!.uid;

    await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .doc(productId)
        .delete();
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    final userId = auth.currentUser!.uid;

    final snapshot = await firestore
        .collection("users")
        .doc(userId)
        .collection("cart")
        .where("productId", isEqualTo: productId)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.update({"quantity": quantity});
    }
  }
}
