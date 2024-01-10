import 'package:flutter/material.dart';

InputDecoration kSearchFieldInputDecorator = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  prefixIcon: const Icon(Icons.search, color: Color(0xFF626266)),
  hintText: 'Search for a customer…',
  hintStyle: const TextStyle(
    color: Color(0xFF626266),
    fontSize: 12,
    fontFamily: 'GT Walsheim Pro',
    fontWeight: FontWeight.w500,
    height: 14 / 12,
  ),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
);
