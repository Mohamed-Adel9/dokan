import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dokan/features/home/data/models/product_model.dart';

abstract class HomeRemoteDataSource {
  Stream<List<ProductModel>> getProducts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore fireStore;

  HomeRemoteDataSourceImpl(this.fireStore);

  @override
  Stream<List<ProductModel>> getProducts() {
    return fireStore.collection('product').snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => ProductModel.fromJson(
        doc.data(),
        // doc.id, // مهم جداً
      )).toList(),
    );
  }
}