import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/product_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsUseCase {
  final HomeRepo _repo;
  GetProductsUseCase(this._repo);

  Future<ApiResult<List<ProductModel>>> call() {
    return _repo.getProducts();
  }
}
