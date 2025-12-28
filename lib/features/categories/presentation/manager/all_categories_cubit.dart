import 'package:flower_shop/features/categories/domain/usecase/all_categories_usecase.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_intent.dart';
import 'package:flower_shop/features/categories/presentation/manager/all_categories_states.dart';
import 'package:flower_shop/features/nav_bar/domain/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  final AllCategoriesUsecase _allCategoriesUsecase;
  AllCategoriesCubit(this._allCategoriesUsecase) : super(AllCategoriesStates());
  List<ProductModel?>? allCategoriesList = [];

  void doIntent(AllCategoriesIntent intent) {
    switch (intent) {
      case GetAllCategoriesEvent():
    }
  }
}
