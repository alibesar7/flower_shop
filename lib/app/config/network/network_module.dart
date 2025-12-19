import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/api_manger/api_client.dart';
import '../../core/values/app_endpoint_strings.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(baseUrl: AppEndpointString.baseUrl));

  @lazySingleton
  ApiClient authApiClient(Dio dio) =>
      ApiClient(dio, baseUrl: AppEndpointString.baseUrl);

}
