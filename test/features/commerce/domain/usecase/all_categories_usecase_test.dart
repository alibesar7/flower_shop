import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/commerce/domain/models/all_categories_model.dart';
import 'package:flower_shop/features/commerce/domain/repos/commerce_repo.dart';
import 'package:flower_shop/features/commerce/domain/usecase/all_categories_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'all_categories_usecase_test.mocks.dart';

@GenerateMocks([CommerceRepo])
void main() {
  late MockCommerceRepo mockRepo;
  late AllCategoriesUsecase usecase;

  setUpAll(() {
    mockRepo = MockCommerceRepo();
    usecase = AllCategoriesUsecase(mockRepo);
    provideDummy<ApiResult<AllCategoriesModel>>(
      SuccessApiResult<AllCategoriesModel>(data: AllCategoriesModel()),
    );
  });
  group('All categories use case', () {
    test(
      'return ApiSuccess when repo return get all categories success',
      () async {
        final fakeData = AllCategoriesModel(
          message: 'success',
          categories: [
            CategoryItemModel(
              id: '1',
              image: 'url',
              name: 'flower1',
              productsCount: 5,
            ),
          ],
        );

        when(mockRepo.getAllCategories()).thenAnswer(
          (_) async => SuccessApiResult<AllCategoriesModel>(data: fakeData),
        );

        final result =
            await usecase.call() as SuccessApiResult<AllCategoriesModel>;

        expect(result, isA<SuccessApiResult<AllCategoriesModel>>());
        expect(result.data.message, fakeData.message);
        expect(
          result.data.categories?.first?.id,
          fakeData.categories?.first?.id,
        );
        verify(mockRepo.getAllCategories()).called(1);
      },
    );

    test('return ApiError when repo return get all categories fail', () async {
      when(mockRepo.getAllCategories()).thenAnswer(
        (_) async =>
            ErrorApiResult<AllCategoriesModel>(error: 'Something went wrong'),
      );

      final result = await usecase.call() as ErrorApiResult<AllCategoriesModel>;

      expect(result, isA<ErrorApiResult<AllCategoriesModel>>());
      expect(result.error, 'Something went wrong');
      verify(mockRepo.getAllCategories()).called(1);
    });
  });
}
