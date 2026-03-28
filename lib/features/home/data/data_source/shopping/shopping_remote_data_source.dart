import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/categories_model.dart';

abstract class ShoppingRemoteDataSource {
  Future<List<CategoriesModel>> getCategories();
}

class ShoppingRemoteDataSourceImpl implements ShoppingRemoteDataSource {
  final FirebaseFirestore fireStore;

  ShoppingRemoteDataSourceImpl(this.fireStore);

  @override
  Future<List<CategoriesModel>> getCategories() async {
    final snapshot = await fireStore.collection('categories').get();

    return snapshot.docs
        .map((doc) => CategoriesModel.fromJson(doc.data()))
        .toList();
  }
}
