import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/commerce/domain/repos/commerce_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AllCategoriesUsecase {
  CommerceRepo categoriesRepo;
  AllCategoriesUsecase(this.categoriesRepo);

  Future<ApiResult<AllCategoriesModel>> call() =>
      categoriesRepo.getAllCategories();
}
