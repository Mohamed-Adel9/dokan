// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import '../../domain/repository/payment_repository.dart';
//
// class PaymentRepositoryImpl implements PaymentRepository {
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;
//   PaymentRepositoryImpl(this._firestore, this._auth);
//
//   @override
//   Future<void> saveTransaction({
//     required String transactionId,
//     required double amount,
//     required String method,
//   }) async {
//     final uid = _auth.currentUser?.uid;
//     if (uid == null) return;
//     await _firestore
//         .collection('users')
//         .doc(uid)
//         .collection('transactions')
//         .add({
//       'transactionId': transactionId,
//       'amount': amount,
//       'method': method,
//       'status': 'success',
//       'createdAt': FieldValue.serverTimestamp(),
//     });
//   }
// }