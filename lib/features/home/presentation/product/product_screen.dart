import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/home/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/product_screen_widgets/add_to_cart_button.dart';
import '../../../../shared/widgets/product_screen_widgets/product_image.dart';
import '../../../../shared/widgets/product_screen_widgets/product_info.dart';
import '../../../../shared/widgets/product_screen_widgets/recommended_products.dart';
import '../../../../shared/widgets/product_screen_widgets/top_actions.dart';
import '../../../../shared/widgets/product_screen_widgets/write_comment_button.dart';
import '../home/bloc/home_cubit.dart';
import '../home/bloc/home_states.dart';

class ProductScreen extends StatelessWidget {
  final String categoryName;
  final String categoryKind;
  final Product product;

  const ProductScreen({
    super.key,
    required this.categoryName,
    required this.product,
    required this.categoryKind,
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            /// Product Images
            ProductImage(image: product.image),

            /// Size + Color + Favorite
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  /// Size + color + favorite picker
                  BlocBuilder<HomeCubit, HomeStates>(
                    builder: (context, state) {
                      if (state is HomeLoadedState) {
                        final updatedProduct = state.product.firstWhere(
                              (p) => p.id == product.id,
                        );

                        return TopActions(product: updatedProduct);
                      }

                      return TopActions(product: product);
                    },
                  ),

                  SizedBox(height: 20),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Product Info
                      ProductInfo(product: product),


                      const SizedBox(height: 20),

                      /// Add to Cart
                      AddToCartButton(product: product),
                      SizedBox(height: 25),
                      RecommendedProducts(),
                      SizedBox(height: 30),
                      WriteCommentButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(categoryName, style: AppTextStyles.headline3),
      centerTitle: true,
    );
  }
}











