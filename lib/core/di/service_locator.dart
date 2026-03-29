import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dokan/features/auth/data/dataSource/auth_remote_data_source.dart';
import 'package:dokan/features/auth/data/repository/auth_repository_impl.dart';
import 'package:dokan/features/auth/domain/repositories/auth_repository.dart';
import 'package:dokan/features/auth/domain/usecases/forget_password/forget_password_usecase.dart';
import 'package:dokan/features/auth/domain/usecases/login/login_facebook_usecase.dart';
import 'package:dokan/features/auth/domain/usecases/logout/logout_usecase.dart';
import 'package:dokan/features/auth/domain/usecases/signup/signup_usecase.dart';
import 'package:dokan/features/auth/presentation/forget_password/bloc/forget_password_cubit.dart';
import 'package:dokan/features/checkout/data/repository/order_repository_imple.dart';
import 'package:dokan/features/checkout/domain/repository/order_repository.dart';
import 'package:dokan/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:dokan/features/home/data/data_source/bag/cart_remote_data_source.dart';
import 'package:dokan/features/home/data/data_source/home/home_local_data_source.dart';
import 'package:dokan/features/home/data/data_source/home/home_remote_data_source.dart';
import 'package:dokan/features/home/data/repositories/bag/cart_repository_impl.dart';
import 'package:dokan/features/home/data/repositories/home_repository_impl.dart';
import 'package:dokan/features/home/data/repositories/rating_repository_impl.dart';
import 'package:dokan/features/home/data/repositories/shopping_repository_impl.dart';
import 'package:dokan/features/home/domain/repositories/bag/cart_repository.dart';
import 'package:dokan/features/home/domain/repositories/home_repository.dart';
import 'package:dokan/features/home/domain/repositories/rate_repository.dart';
import 'package:dokan/features/home/domain/repositories/shopping_repository.dart';
import 'package:dokan/features/home/domain/usecases/bag/add_to_cart_use_case.dart';
import 'package:dokan/features/home/domain/usecases/bag/get_cart_use_case.dart';
import 'package:dokan/features/home/domain/usecases/bag/remove_from_cart_use_case.dart';
import 'package:dokan/features/home/domain/usecases/get_product_usecase.dart';
import 'package:dokan/features/home/domain/usecases/get_ratings_usecase.dart';
import 'package:dokan/features/home/presentation/bag/bloc/cart_cubit.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_cubit.dart';
import 'package:dokan/features/home/presentation/shopping/bloc/shopping_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/auth/domain/usecases/login/login_google_usecase.dart';
import '../../features/auth/domain/usecases/login/login_usecase.dart';
import '../../features/auth/presentation/login/bloc/login_cubit.dart';
import '../../features/auth/presentation/signup/bloc/signup_cubit.dart';
import '../../features/checkout/data/data_source/order_remote_data_source.dart';
import '../../features/checkout/domain/usecases/create_order_use_case.dart';
import '../../features/home/data/data_source/rate/rating_local_data_source.dart';
import '../../features/home/data/data_source/rate/rating_remote_data_source.dart';
import '../../features/home/data/data_source/shopping/shopping_local_data_source.dart';
import '../../features/home/data/data_source/shopping/shopping_remote_data_source.dart';
import '../../features/home/domain/usecases/bag/update_cart_item_use_case.dart';
import '../../features/home/domain/usecases/get_categories_usecase.dart';
import '../../features/home/presentation/home/bloc/home_cubit.dart';
import '../../features/payment/data/data_source/payment_local_data_source.dart';
import '../../features/payment/data/data_source/payment_remote_data_source.dart';
import '../../features/payment/data/repository/payment_repository_impl.dart';
import '../../features/payment/domain/repository/payment_repository.dart';
import '../../features/payment/domain/usecases/get_transactions_use_case.dart';
import '../../features/payment/domain/usecases/pay_with_card_use_case.dart';
import '../../features/payment/domain/usecases/pay_with_wallet_use_case.dart';
import '../../features/payment/presentation/bloc/payment_cubit.dart';

final sl = GetIt.instance;

Future<void> setupGetIt() async {
  // 🔥 External services first
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FacebookAuth.instance);
  sl.registerLazySingleton(() => Connectivity());

  // 📡 Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl<FirebaseAuth>(),
      googleSignIn: sl<GoogleSignIn>(),
      facebookAuth: sl<FacebookAuth>(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ShoppingRemoteDataSource>(
    () => ShoppingRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ShoppingLocalDataSource>(
    () => ShoppingLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<RatingRemoteDataSource>(
    () => RatingRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RatingLocalDataSource>(
    () => RatingLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(firestore: sl(), auth: sl()),
  );
  sl.registerLazySingleton<PaymentLocalDataSource>(
    () => PaymentLocalDataSourceImpl(),
  );

  //📦 Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl(), sl(), sl()),
  );
  sl.registerLazySingleton<ShoppingRepository>(
    () => ShoppingRepositoryImpl(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<RateRepository>(
    () => RatingRepositoryImpl(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(remote: sl(), local: sl(), connectivity: sl()),
  );

  /// 🎯 Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LoginGoogleUseCase(sl()));
  sl.registerLazySingleton(() => LoginFacebookUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetRatingsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartItemUseCase(repository: sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(repository: sl()));
  sl.registerLazySingleton(() => PayWithCardUseCase(sl()));
  sl.registerLazySingleton(() => PayWithWalletUseCase(sl()));
  sl.registerLazySingleton(() => GetTransactionsUseCase(sl()));

  /// 🧠 Cubit
  sl.registerFactory(
    () => LoginCubit(
      sl<LoginGoogleUseCase>(),
      sl<LoginUseCase>(),
      sl<LoginFacebookUseCase>(),
      sl<LogoutUseCase>(),
    ),
  );
  sl.registerFactory(() => SignupCubit(sl<SignupUseCase>()));
  sl.registerFactory(() => ForgetPasswordCubit(sl<ForgetPasswordUseCase>()));
  sl.registerFactory(() => HomeCubit(sl<GetProductUseCase>()));
  sl.registerFactory(() => ShoppingCubit(sl<GetCategoriesUseCase>()));
  sl.registerFactory(() => RatingCubit(sl<GetRatingsUseCase>()));
  sl.registerFactory(() => CartCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => CheckoutCubit(sl()));
  sl.registerFactory(
    () => PaymentCubit(
      payWithCard: sl(),
      payWithWallet: sl(),
      getTransactions: sl(),
    ),
  );
}
