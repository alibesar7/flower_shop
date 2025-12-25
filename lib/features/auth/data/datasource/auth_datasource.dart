import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/auth/data/models/request/login_request_model.dart';
import 'package:flower_shop/features/auth/data/models/response/login_response_model.dart';

abstract class AuthDatasource {
  Future<ApiResult<LoginResponse>?> login(LoginRequest loginRequest);
}
