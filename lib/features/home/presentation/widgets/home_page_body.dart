import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/features/home/presentation/widgets/Category_item.dart';
import 'package:flower_shop/features/home/presentation/widgets/home_header.dart';
import 'package:flower_shop/features/home/presentation/widgets/home_section.dart';
import 'package:flower_shop/features/home/presentation/widgets/p.dart';
import 'package:flower_shop/features/home/presentation/widgets/product_item.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/features/home/presentation/manager/home_cubit.dart';
import 'package:flower_shop/features/home/presentation/manager/home_states.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const HomeHeader(),
              const SizedBox(height: 10),

              /// Categories
              HomeSection(
                title: LocaleKeys.categories.tr(),
                onTap: () {
                  // Navigate to categories page
                },
                height: 90,
                resource: state.categories,
                itemBuilder: (context, category) {
                  return CategoryItem(
                    image: category.image ?? "",
                    label: category.name ?? "",
                    onTap: () {},
                  );
                },
              ),

              /// Best Sellers
              HomeSection(
                title: LocaleKeys.bestSelling.tr(),
                onTap: () {
                  // Navigate to best sellers page
                },
                height: 220,
                resource: state.bestSeller,
                itemBuilder: (context, product) {
                  return ProductItem(
                    imageUrl: product.imgCover ?? "",
                    title: product.title ?? "",
                    price: product.price?.toString(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsPage(product: product),
                        ),
                      );
                    },
                  );
                },
              ),

              /// Occasions
              HomeSection(
                title: LocaleKeys.occasions.tr(),
                onTap: () {
                  // Navigate to occasions page
                },
                height: 220,
                resource: state.occasions,
                itemBuilder: (context, occasion) {
                  return ProductItem(
                    imageUrl: occasion.image ?? "",
                    title: occasion.name ?? "",
                    onTap: () {},
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
