import 'package:flutter/material.dart';

class PackageTour {
  final int id;
  final String name;
  final String description;
  final String shortDescription;
  final double price;
  final String startTime;
  final String endTime;
  final int attendance;
  final bool status;

  PackageTour({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.startTime,
    required this.endTime,
    required this.attendance,
    required this.status,
  });

  factory PackageTour.fromJson(Map<String, dynamic> json) {
    return PackageTour(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['shortDescription'],
      price: json['price'].toDouble(),
      startTime: json['startTime'],
      endTime: json['endTime'],
      attendance: json['attendance'],
      status: json['status'],
    );
  }
}

class CartItem {
  final int id;
  final double totalPrice;
   int quantity;
  final PackageTour packageTour;

  CartItem({
    required this.id,
    required this.totalPrice,
    required this.quantity,
    required this.packageTour,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      totalPrice: json['totalPrice'].toDouble(),
      quantity: json['quantity'],
      packageTour: PackageTour.fromJson(json['packageTour']),
    );
  }
}
