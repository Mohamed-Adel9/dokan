import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/auth/presentation/forget_password/bloc/forget_password_cubit.dart';
import 'package:dokan/features/auth/presentation/forget_password/forget_password_screen.dart';
import 'package:dokan/features/auth/presentation/signup/bloc/signup_cubit.dart';
import 'package:dokan/features/auth/presentation/signup/signup_screen.dart';
import 'package:dokan/features/checkout/presentation/address_screen.dart';
import 'package:dokan/features/checkout/presentation/bloc/checkout_cubit.dart';
import 'package:dokan/features/checkout/presentation/check_out_screen.dart';
import 'package:dokan/features/checkout/presentation/check_out_screen_args.dart';
import 'package:dokan/features/checkout/presentation/check_out_success_screen.dart';
import 'package:dokan/features/home/presentation/bag/bloc/cart_cubit.dart';
import 'package:dokan/features/home/presentation/home/home_screen.dart';
import 'package:dokan/features/home/presentation/product/bloc/rate_cubit.dart';
import 'package:dokan/features/home/presentation/product/product_screen.dart';
import 'package:dokan/features/home/presentation/product/rating_screen.dart';
import 'package:dokan/features/home/presentation/profile/setting_screen.dart';
import 'package:dokan/features/home/presentation/shopping/bloc/shopping_cubit.dart';
import 'package:dokan/features/home/presentation/shopping/product_view/shopping_product_show.dart';
import 'package:dokan/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/login/login_screen.dart';
import '../../features/checkout/presentation/payment_method_screen.dart';
import '../../features/home/presentation/home/bloc/home_cubit.dart';
import '../../features/home/presentation/shopping/product_screen_args.dart';
import '../../features/home/presentation/shopping/shopping_args.dart';
import '../di/service_locator.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// login router
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());

      ///signup router
      case RouteNames.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<SignupCubit>(),
            child: SignUpScreen(),
          ),
        );

      ///setting router
      case RouteNames.setting:
        return MaterialPageRoute(builder: (context) => SettingsScreen());

      ///product router
      case RouteNames.product:
        final args = settings.arguments as ProductScreenArgs;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<HomeCubit>()..listenToProducts(),
              ),
              BlocProvider(
                create: (context) => sl<CartCubit>()..listenToCart(),
              ),
            ],
            child: ProductScreen(
              product: args.products,
              categoryKind: args.categoryKind,
              categoryName: args.categoryName,
            ),
          ),
        );

      ///forgetPassword router
      case RouteNames.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<ForgetPasswordCubit>(),
            child: ForgetPasswordScreen(),
          ),
        );

      ///rate router
      case RouteNames.rate:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => sl<RatingCubit>()..loadRating(),
            child: RatingScreen(),
          ),
        );

      ///home router
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => BottomNavCubit()),
              BlocProvider(create: (_) => sl<HomeCubit>()..listenToProducts()),
              BlocProvider(create: (_) => sl<ShoppingCubit>()..loadCategories()),
              BlocProvider(create: (_) => sl<CartCubit>()..listenToCart()),
            ],
            child: HomeScreen(),
          ),
        );

      ///splash router
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => Splashscreen());

      ///address router
      case RouteNames.address:
        return MaterialPageRoute(builder: (context) => AddressScreen());

      ///checkout router
      case RouteNames.checkout:
        final args = settings.arguments as CheckOutScreenArgs;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CheckoutCubit>()),
              BlocProvider(
                create: (context) => sl<CartCubit>()..listenToCart(),
              ),
            ],
            child: CheckOutScreen(
              totalPrice: args.totalPrice,
              totalPriceAfterDiscount: args.totalPriceAfterDiscount,
              delivery: args.delivery,
            ),
          ),
        );

      ///CheckOutSuccessScreen router
      case RouteNames.checkoutSuccess:
        return MaterialPageRoute(builder: (context) => CheckOutSuccessScreen());

      ///payment router
      case RouteNames.payment:
        final orderAmount = settings.arguments as double;
        final orderAmountAfterDis = settings.arguments as double;

        return MaterialPageRoute(builder: (context) => PaymentMethodScreen(orderAmount: orderAmount, orderAmountAfterDis: orderAmountAfterDis,));

      ///shoppingProductShow router
      case RouteNames.shoppingProductShow:
        final args = settings.arguments as ShoppingArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => sl<HomeCubit>()..listenToProducts(),
            child: ShoppingProductShow(
              categoryName: args.categoryName,
              products: args.products,
              categoryKind: args.categoryKind,
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("Page not found", style: AppTextStyles.headline),
            ),
          ),
        );
    }
  }
}
