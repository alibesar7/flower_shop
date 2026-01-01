import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/data/datasource/commerce_remote_datasource.dart';
import 'package:flower_shop/features/commerce/data/mappers/all_categories_mapper.dart';
import 'package:flower_shop/features/commerce/data/models/all_categories_dto.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/commerce/domain/repos/commerce_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CommerceRepo)
class CommerceRepoImpl implements CommerceRepo {
  CommerceRemoteDatasource categoriesDatasource;
  CommerceRepoImpl(this.categoriesDatasource);

  @override
  Future<ApiResult<AllCategoriesModel>> getAllCategories() async {
    final result = await categoriesDatasource.getAllCategories();
    switch (result) {
      case SuccessApiResult<AllCategoriesDto>():
        AllCategoriesDto dto = result.data;
        AllCategoriesModel allCategoriesModel = dto.toAllCategoriesModel();
        return SuccessApiResult<AllCategoriesModel>(data: allCategoriesModel);
      case ErrorApiResult<AllCategoriesDto>():
        return ErrorApiResult<AllCategoriesModel>(error: result.error);
    }
  }
}
