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
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Customer>.from(json["data"].map((x) => Customer.fromJson(x))),
        support: Support.fromJson(json["support"]),
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

  const Customer({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Customer.fromJson(dynamic json) => Customer(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );
  @override
  bool operator ==(covariant Customer other) => identical(this, other) || (id == other.id);

  @override
  int get hashCode => Object.hash(id, email);
}

class Support {
  final String url;
  final String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(dynamic json) => Support(url: json["url"], text: json["text"]);
}
