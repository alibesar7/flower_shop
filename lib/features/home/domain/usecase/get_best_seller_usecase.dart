import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/home/domain/models/best_seller_model.dart';
import 'package:flower_shop/features/home/domain/repos/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellerUseCase {
  final HomeRepo _repo;
  GetBestSellerUseCase(this._repo);

  Future<ApiResult<List<BestSellerModel>>> call() {
    return _repo.getBestSeller();
  }
}
