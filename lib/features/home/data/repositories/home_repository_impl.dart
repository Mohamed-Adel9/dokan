import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dokan/features/home/data/data_source/home/home_local_data_source.dart';
import 'package:dokan/features/home/data/data_source/home/home_remote_data_source.dart';
import 'package:dokan/features/home/domain/entities/product.dart';
import 'package:dokan/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemoteDataSource remote ;
  final HomeLocalDataSource local ;
  final Connectivity connectivity ;

  HomeRepositoryImpl(this.remote, this.local, this.connectivity);

  @override
  @override
  Stream<List<Product>> getProducts() async* {
    try {
      final connection = await connectivity.checkConnectivity();

      if (connection.first != ConnectivityResult.none) {
        yield* remote.getProducts().map((products) {
          local.cacheProducts(products);
          return products;
        });
      } else {
        yield* local.getCachedProducts();
      }

    } catch (e) {
      throw Exception(e.toString());
    }
  }
}