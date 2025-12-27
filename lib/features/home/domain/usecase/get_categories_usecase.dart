import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/category_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetCategoriesUseCase {
  final HomeRepo _repo;
  GetCategoriesUseCase(this._repo);

  Future<ApiResult<List<CategoryModel>>> call() {
    return _repo.getCategories();
  }
}
