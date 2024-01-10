import 'package:dio/dio.dart';
import 'package:hustlesasa_code_challenge/models/customer.dart';
import 'package:hustlesasa_code_challenge/network/network.dart';

import '../models/base_response.dart';
import '../network/endpoints.dart';

/// Customer reposir\tory where
class CustomerRepository {
  final DioClient _dioClient = const DioClient();
  Future<BaseResponse<CustomerResponse>> fetchCustomers() async {
    try {
      final response = await _dioClient.call(path: Endpoints.customers, requestMethod: RequestMethod.get);
      final customer = CustomerResponse.fromJson(response.data);
      return BaseResponse.success(customer);
    } on DioException catch (error, _) {
      return BaseResponse.errorMessage(message: error.response?.statusMessage);
    } catch (error) {
      return BaseResponse.errorMessage(message: error.toString());
    }
  }
}
