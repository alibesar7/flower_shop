import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/config/di/di.dart';
import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/e_commerce/presentation/occasion/pages/shimmer_grid_loading.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_intent.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_states.dart';
import 'package:flower_shop/features/orders/presentation/widgets/cart_item_widget.dart';
import 'package:flower_shop/features/orders/presentation/widgets/total_price_section.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  final bloc = getIt<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leadingWidth: 50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          iconSize: 20,
          onPressed: () {
            context.go(RouteNames.home);
          },
        ),

        title: Row(
          children: [
            Text(
              LocaleKeys.cart.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.blackColor,
                fontSize: 20,
              ),
            ),
            Text(
              '  (${bloc.state.cart?.data?.numOfCartItems} ${LocaleKeys.items.tr()})',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppColors.grey),
                const SizedBox(width: 3),
                Text(
                  "${LocaleKeys.deliverTo.tr()} 2XVP+XC - Sheikh Zayed",
                  style: Theme.of(context).textTheme.labelSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_down, color: AppColors.blackColor),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocProvider<CartCubit>(
                create: (context) => bloc..doIntent(GetAllCartsIntent()),
                child: BlocBuilder<CartCubit, CartStates>(
                  builder: (context, state) {
                    final carts = state.cart?.data?.cart?.cartItems;
                    if (state.cart?.status == Status.loading || carts == null) {
                      return const ShimmerGridLoading();
                    }
                    if (carts.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            LocaleKeys.noProductsfound.tr(),
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: carts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = carts[index];
                              return product != null
                                  ? CartItemWidget(cartModel: product)
                                  : const SizedBox();
                            },
                          ),
                        ),
                        TotalPriceSection(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
