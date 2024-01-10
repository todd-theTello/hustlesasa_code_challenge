import 'package:dio/dio.dart';

import '../models/base_response.dart';
import '../models/customer.dart';
import '../network/endpoints.dart';
import '../network/network.dart';

/// Customer repository
class CustomerRepository {
  final DioClient _dioClient = const DioClient();

  /// function to fetch all users
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
