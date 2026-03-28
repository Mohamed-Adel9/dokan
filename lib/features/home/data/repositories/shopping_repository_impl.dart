import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dokan/core/errors/failures.dart';

import '../../domain/entities/categories.dart';
import '../../domain/repositories/shopping_repository.dart';
import '../data_source/shopping/shopping_local_data_source.dart';
import '../data_source/shopping/shopping_remote_data_source.dart';

class ShoppingRepositoryImpl implements ShoppingRepository{
  final ShoppingRemoteDataSource remote ;
  final ShoppingLocalDataSource local ;
  final Connectivity connectivity ;

  ShoppingRepositoryImpl(this.remote, this.local, this.connectivity);

  @override
  Future<Either<Failures, List<Categories>>> getCategories() async {
    final connection = await connectivity.checkConnectivity();

    try{
      /// online
      if(connection.first != ConnectivityResult.none){
        final remoteCategories = await remote.getCategories();
        await local.cacheCategories(remoteCategories);
        return Right(remoteCategories);
      }

      ///offline
      final localCategories = await local.getCachedCategories();
      return Right(localCategories);

    } catch (e){
      throw Left(e.toString());
    }
  }
}