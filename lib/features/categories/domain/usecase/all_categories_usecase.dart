import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/categories/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/categories/domain/repos/all_categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllCategoriesUsecase {
  AllCategoriesRepo categoriesRepo;
  AllCategoriesUsecase(this.categoriesRepo);

  Future<ApiResult<AllCategoriesModel>> call() =>
      categoriesRepo.getAllCategories();
}
