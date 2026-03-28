import 'package:dokan/core/navigation/route_names.dart';
import 'package:dokan/core/theme/app_text_styles.dart';
import 'package:dokan/features/checkout/presentation/check_out_screen_args.dart';
import 'package:dokan/features/home/presentation/bag/bloc/cart_cubit.dart';
import 'package:dokan/shared/widgets/auth_button.dart';
import 'package:dokan/shared/widgets/bag_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../shared/functions/price_summary.dart';
import 'bloc/cart_state.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is CartLoadedState){
            double totalPrice = state.items.fold(
              0,
                  (sum, item) => sum + (item.price * item.quantity),
            );
            double totalPriceAfterDiscount = state.items.fold(
              0,
                  (sum, item) => sum + (item.finalPrice * item.quantity),
            );
            double delivery = 25 ;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context).translate('my_bag'), style: AppTextStyles.headline,),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: BagCard(item: item,onDecrease: (){
                            context.read<CartCubit>().decreaseQuantity(item);
                          },onIncrease:(){
                            context.read<CartCubit>().increaseQuantity(item);
                          } ,),
                        );
                    },
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                  ),
                ),

                PriceSummary(
                    subtotal: totalPrice,
                    totalAfterDiscount:totalPriceAfterDiscount ,
                    delivery: delivery
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: AuthButton(
                          text: AppLocalizations.of(context).translate('checkout'),
                          onPressed: () {
                    Navigator.pushNamed(
                        context,
                        RouteNames.checkout,
                      arguments: CheckOutScreenArgs
                        (delivery: delivery,
                          totalPrice: totalPrice,
                          totalPriceAfterDiscount: totalPriceAfterDiscount,
                      ),
                    );
                  })),
                )

              ],
            );
          }
          return Center(
            child: Text("OOPS! something went wrong",style: AppTextStyles.headline3,),
          );
        },
      ),
    );
  }
}
