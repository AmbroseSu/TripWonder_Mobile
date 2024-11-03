class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Order {
  final int id;
  final String name;
  final String state;
  final DateTime startTime;
  final DateTime endTime;
  final Category category;
  final int orderCode;

  Order({
    required this.id,
    required this.name,
    required this.state,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.orderCode,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      state: json['state'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      category: Category.fromJson(json['category']),
      orderCode: json['orderCode'],
    );
  }
}
