import 'package:flutter/cupertino.dart';
import 'package:hustlesasa_code_challenge/models/customer.dart';
import 'package:hustlesasa_code_challenge/repository/customers.dart';

part 'customer_state.dart';

/// customer controller, this is equivalent to cubit or bloc class in bloc or
/// State notifier/ Async Notifier / Notifier class in Riverpod
class CustomerController extends ValueNotifier<CustomerState> {
  CustomerController() : super(CustomerInitial());
  final CustomerRepository _repository = CustomerRepository();
  Future<void> fetchCustomers() async {
    value = CustomerLoading();
    final response = await _repository.fetchCustomers();
    if (response.status) {
      final CustomerResponse customer = response.data!;
      value = CustomerSuccess(customer: customer.data);
    } else {
      value = CustomerFailure(error: response.message ?? 'Check your internet connection');
    }
  }

  void addCustomer({required Customer newCustomer, required List<Customer> oldCustomers}) {
    value = CustomerLoading();
    value = CustomerSuccess(
      customer: [...oldCustomers, newCustomer],
    );
    print(value.toString());
  }
}
