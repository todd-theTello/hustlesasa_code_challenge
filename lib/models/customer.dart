import 'package:flutter/material.dart';

/// Response model for customers from network call
class CustomerResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<Customer> data;
  final Support support;

  CustomerResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  factory CustomerResponse.fromJson(dynamic json) => CustomerResponse(
        page: int.parse(json['page'].toString()),
        perPage: int.parse(json['per_page'].toString()),
        total: int.parse(json['total'].toString()),
        totalPages: int.parse(json['total_pages'].toString()),
        data: List<Customer>.from((json['data'] as List<dynamic>).map(Customer.fromJson)),
        support: Support.fromJson(json['support']),
      );
}

@immutable

/// Customer data model
class Customer {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final bool isSelected;
  const Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.isSelected,
  });

  factory Customer.fromJson(dynamic json) => Customer(
        id: int.parse(json['id'].toString()),
        email: json['email'] as String,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        avatar: json['avatar'] as String,
        isSelected: false,
      );
  Customer copyWithIsSelected({required bool isSelected}) {
    return Customer(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      isSelected: isSelected,
    );
  }

  @override
  bool operator ==(covariant Customer other) => identical(this, other) || (id == other.id);

  @override
  int get hashCode => Object.hash(id, email);
}

class Support {
  final String url;
  final String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(dynamic json) => Support(url: json['url'].toString(), text: json['text'].toString());
}
