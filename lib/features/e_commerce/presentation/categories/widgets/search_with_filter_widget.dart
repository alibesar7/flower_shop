import 'package:flower_shop/app/core/router/route_names.dart';
import 'package:flower_shop/app/core/ui_helper/assets/images.dart';
import 'package:flower_shop/app/core/ui_helper/color/colors.dart';
import 'package:flower_shop/features/home/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchWithFilter extends StatelessWidget {
  const SearchWithFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: SearchTextField(
              onTap: () => context.push(RouteNames.searchPage),
            ),
          ),

          const SizedBox(width: 12),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 64,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(Assets.imagesFilter, color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
