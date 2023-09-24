class Product {
  final String nameDrug;
  final String image;
  final double price;
  final String startdate;
  final String enddate;
  final String dayremain;
  int quantity;
  

  Product({
    required this.nameDrug,
    required this.image,
    required this.price,
    required this.quantity,
    required this.dayremain,
    required this.enddate,
    required this.startdate
  });

  Product copyWith({
    String? nameDrug,
    String? image,
    String? dayremain,
    double? price,
    int? quantity,
    String? enddate,
    String? startdate,
  }) {
    return Product(
      nameDrug: nameDrug ?? this.nameDrug,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      startdate: startdate ?? this.startdate,
      enddate: enddate ?? this.enddate,
      dayremain: dayremain ?? this.dayremain,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nameDrug: json['nameDrug'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'] ?? 1,
      startdate: json['startdate'],
      enddate: json['enddate'],
      dayremain: json['dayremain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameDrug': nameDrug,
      'image': image,
      'price': price,
      'quantity': quantity,
      'startdate': startdate,
      'enddate': enddate,
      'dayremain':dayremain,
    };
  }
}
