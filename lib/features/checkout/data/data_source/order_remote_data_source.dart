import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/order_model.dart';

abstract class OrderRemoteDataSource{
  Future<void> createOrder(OrderModel order);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {

  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> createOrder(OrderModel order) async {

    final orderRef = firestore.collection("orders").doc();

    await orderRef.set(order.toJson());
  }
}