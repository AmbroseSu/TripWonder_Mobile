import 'package:flutter/material.dart';

class Tour {
  final int id;
  final String name;
  final double price;
  final String description;
  final String shortDescription;
  final DateTime startTime;
  final DateTime endTime;
  final int attendance;
  final String province;
  final List<int> ratingReviews;  // Đổi thành List<int>
  final List<String> galleries;
  final String category;

  Tour({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.shortDescription,
    required this.startTime,
    required this.endTime,
    required this.attendance,
    required this.province,
    required this.ratingReviews,
    required this.galleries,
    required this.category,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      shortDescription: json['shortDescription'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      attendance: json['attendance'],
      province: json['province'],
      ratingReviews: (json['ratingReviews'] as List)
        .map((e) => e['rating'] as int)
        .toList(), // Đổi cách lấy dữ liệu ratingReviews
      galleries: (json['galleries'] as List)
          .map((e) => e['imageUrl'] as String)
          .toList(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'shortDescription': shortDescription,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'attendance': attendance,
      'province': province,
      'ratingReviews': ratingReviews, // Trả về list int
      'galleries': galleries.map((url) => {'imageUrl': url}).toList(),
      'category': category,
    };
  }

  String? getFirstImageUrl() {
    return galleries.isNotEmpty ? galleries.first : null;
  }

  factory Tour.fromMap(Map<String, dynamic> map) {
    return Tour(
      id: map['id'] as int,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      description: map['description'] as String,
      shortDescription: map['shortDescription'] as String,
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      attendance: map['attendance'] as int,
      province: map['province'] as String,
      ratingReviews: (map['ratingReviews'] as List)
          .map((e) => e['rating'] as int)
          .toList(),
      galleries: (map['galleries'] as List)
          .map((e) => e['imageUrl'] as String)
          .toList(),
      category: map['category'] as String,
    );
  }

}