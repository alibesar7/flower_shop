import 'package:flutter/material.dart';

class AllCategoriesList extends StatefulWidget {
  const AllCategoriesList({super.key});

  @override
  State<AllCategoriesList> createState() => _AllCategoriesListState();
}

class _AllCategoriesListState extends State<AllCategoriesList> {
  int selectedIndex = 0;

  final List<String> categories = [
    'All',
    'Flowers',
    'Gifts',
    'Card',
    'Jewelry',
    'Jewelry',
    'Jewelry',
    'Jewelry',
    'Jewelry',
    'Jewelry',
    'Jewelry',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.pink : Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 2,
                  width: _textWidth(categories[index]),
                  color: isSelected ? Colors.pink : Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _textWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 14)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.size.width;
  }
}
