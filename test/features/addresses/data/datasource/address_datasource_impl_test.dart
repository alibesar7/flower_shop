import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import 'package:flower_shop/app/core/api_manger/api_client.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/addresses/data/datasource/address_datasource_impl.dart';
import 'package:flower_shop/features/addresses/data/models/address_model.dart';
import 'package:flower_shop/features/addresses/data/models/address_request.dart';
import 'package:flower_shop/features/addresses/data/models/address_response.dart';
import 'package:flower_shop/features/addresses/data/models/get_address_response.dart';

import '../../../auth/api/datasource/auth_remote_datasource_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late AddressDatasourceImpl datasource;

  setUp(() {
    mockApiClient = MockApiClient();
    datasource = AddressDatasourceImpl(mockApiClient);
  });

  final token = 'fake_token';
  final addressId = 'address_123';
  final addressRequest = AddressRequest(
    street: 'Main Street',
    phone: '01000000000',
    city: 'Cairo',
    lat: '30.01',
    long: '31.02',
    username: 'Ali',
  );

  final addressModel = Address(
    id: '1',
    street: 'Main Street',
    phone: '01000000000',
    city: 'Cairo',
    lat: '30.01',
    long: '31.02',
    username: 'Ali',
  );

  group('AddressDatasourceImpl', () {
    test('getAddresses returns SuccessApiResult', () async {
      final apiResponse = GetAddressResponse(
        addresses: [addressModel],
        message: 'Success',
        error: null,
      );

      when(mockApiClient.getAddresses(token: token)).thenAnswer(
        (_) async => HttpResponse(
          apiResponse,
          Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
        ),
      );

      final result = await datasource.getAddresses(token: token);

      expect(result, isA<SuccessApiResult<GetAddressResponse>>());
      expect(
        (result as SuccessApiResult).data.addresses!.first.street,
        'Main Street',
      );
      verify(mockApiClient.getAddresses(token: token)).called(1);
    });

    test('deleteAddress returns SuccessApiResult', () async {
      final apiResponse = AddressResponse(
        address: [addressModel],
        message: 'Deleted',
        error: null,
      );

      when(
        mockApiClient.deleteAddress(token: token, addressId: addressId),
      ).thenAnswer(
        (_) async => HttpResponse(
          apiResponse,
          Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
        ),
      );

      final result = await datasource.deleteAddress(
        token: token,
        addressId: addressId,
      );

      expect(result, isA<SuccessApiResult<AddressResponse>>());
      expect((result as SuccessApiResult).data.address!.first.id, '1');
      verify(
        mockApiClient.deleteAddress(token: token, addressId: addressId),
      ).called(1);
    });

    test('editAddress returns SuccessApiResult', () async {
      final apiResponse = AddressResponse(
        address: [
          Address(
            id: '1',
            street: 'Updated Street',
            phone: '01000000000',
            city: 'Cairo',
            lat: '30.01',
            long: '31.02',
            username: 'Ali',
          ),
        ],
        message: 'Updated',
        error: null,
      );

      when(
        mockApiClient.editAddress(
          token: token,
          addressId: addressId,
          request: addressRequest,
        ),
      ).thenAnswer(
        (_) async => HttpResponse(
          apiResponse,
          Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
        ),
      );

      final result = await datasource.editAddress(
        token: token,
        addressId: addressId,
        addressRequest: addressRequest,
      );

      expect(result, isA<SuccessApiResult<AddressResponse>>());
      expect(
        (result as SuccessApiResult).data.address!.first.street,
        'Updated Street',
      );
      verify(
        mockApiClient.editAddress(
          token: token,
          addressId: addressId,
          request: addressRequest,
        ),
      ).called(1);
    });

    test('getAddresses returns ErrorApiResult on DioError', () async {
      when(mockApiClient.getAddresses(token: token)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          message: 'Network Error',
          type: DioExceptionType.unknown,
        ),
      );

      final result = await datasource.getAddresses(token: token);

      expect(result, isA<ErrorApiResult<GetAddressResponse>>());
      expect((result as ErrorApiResult).error, contains('Network Error'));
    });
  });
}
