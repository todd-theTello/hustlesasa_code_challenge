part of 'customer_controller.dart';

@immutable
sealed class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerSuccess extends CustomerState {
  CustomerSuccess({required this.customer});
  final List<Customer> customer;
}

class CustomerFailure extends CustomerState {
  CustomerFailure({required this.error});
  final String error;
}
