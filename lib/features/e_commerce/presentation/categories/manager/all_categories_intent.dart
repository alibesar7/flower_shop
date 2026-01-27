import 'package:flower_shop/features/e_commerce/domain/models/sort_type.dart';

sealed class AllCategoriesIntent {}

class GetAllCategoriesEvent extends AllCategoriesIntent {}

class SelectCategoryEvent extends AllCategoriesIntent {
  int selectedIndex;
  SelectCategoryEvent({this.selectedIndex = 0});
}

class ApplySortEvent extends AllCategoriesIntent {
  final SortType sortType;
  ApplySortEvent(this.sortType);
}
