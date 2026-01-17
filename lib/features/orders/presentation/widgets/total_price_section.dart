import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/app/core/widgets/custom_button.dart';
import 'package:flower_shop/features/orders/presentation/manager/cart_cubit.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalPriceSection extends StatelessWidget {
  const TotalPriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (LocaleKeys.subTotal.tr()),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              ("${BlocProvider.of<CartCubit>(context).state.cart?.data?.cart?.totalPrice}\$"),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (LocaleKeys.deliveryFee.tr()),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              ("10\$"),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Divider(color: AppColors.white70, thickness: 0.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (LocaleKeys.total.tr()),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.blackColor),
            ),
            Text(
              ("${(BlocProvider.of<CartCubit>(context).state.cart?.data?.cart?.totalPrice)! + 10}\$"),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: AppColors.blackColor),
            ),
          ],
        ),
        const SizedBox(height: 48),
        CustomButton(
          isEnabled: true,
          isLoading: false,
          text: LocaleKeys.checkout.tr(),
          onPressed: () {},
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
