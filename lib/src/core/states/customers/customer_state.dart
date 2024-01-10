part of 'customer_controller.dart';

@immutable

/// Customer process state
sealed class CustomerState {}

/// initial process state of customer
class CustomerInitial extends CustomerState {}

/// loading process state of customer
class CustomerLoading extends CustomerState {}

/// Success process state of customer
class CustomerSuccess extends CustomerState {
  /// constructor
  CustomerSuccess({required this.customers});

  /// list of customers
  final List<Customer> customers;
}

/// failure process state of customer
class CustomerFailure extends CustomerState {
  /// constructor
  CustomerFailure({required this.error});

  /// Error message
  final String error;
}
