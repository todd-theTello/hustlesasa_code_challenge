import 'package:flutter/cupertino.dart';
import 'package:hustlesasa_code_challenge/models/customer.dart';
import 'package:hustlesasa_code_challenge/repository/customers.dart';

part 'customer_state.dart';

/// customer controller, this is equivalent to cubit or bloc class in bloc or
/// State notifier/ Async Notifier / Notifier class in Riverpod
class CustomerController extends ValueNotifier<CustomerState> {
  CustomerController() : super(CustomerInitial());
  final CustomerRepository _repository = CustomerRepository();

  /// Make network call to get customers
  Future<void> fetchCustomers() async {
    value = CustomerLoading();
    final response = await _repository.fetchCustomers();

    /// Check whether the request to fetch customers was success full
    if (response.status) {
      final CustomerResponse customer = response.data!;

      /// assign the success state to the value of the value notifier
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
  }

  void selectCustomer({required Customer selectedCustomer, required List<Customer> customers}) {
    value = CustomerLoading();
    final index = customers.indexOf(selectedCustomer);
    customers[index] = selectedCustomer.copyWithIsSelected(isSelected: !selectedCustomer.isSelected);
    value = CustomerSuccess(customer: customers);
  }

  void selectOrDeselectAll({required List<Customer> customers, bool isSelect = true}) {
    value = CustomerLoading();
    value = CustomerSuccess(
      customer: customers.map((e) => e.copyWithIsSelected(isSelected: isSelect)).toList(),
    );
  }

  void deleteSelected({required List<Customer> customers}) {
    value = CustomerLoading();
    customers.removeWhere((element) => element.isSelected);
    value = CustomerSuccess(customer: customers);
  }
}
