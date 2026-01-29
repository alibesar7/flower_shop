import 'package:easy_localization/easy_localization.dart';
import 'package:flower_shop/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class DeliveryTimeWidget extends StatelessWidget {
  const DeliveryTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.access_time, size: 18),
        const SizedBox(width: 8),
        Text(
          LocaleKeys.instant_delivery_info.tr(),
          style: const TextStyle(fontSize: 13),
        ),
        const Spacer(),
        Text(
          LocaleKeys.schedule.tr(),
          style: const TextStyle(
            color: Colors.pink,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
