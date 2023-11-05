class Product {
  final String namedrug;
  final String image;
  final double price;
  //final String enddate;
  int quantity;
  
  //namedrug
  //

  Product({
    required this.namedrug,
    required this.image,
    required this.price,
    //required this.enddate,
    required this.quantity,
  });

   Map<String, dynamic> toMap() {
    return {
      'namedrug': namedrug,
      'image': image,
      'price': price,
      'quantity': quantity,
      //'enddate': enddate,
    };
  }

  Product copyWith({
    String? namedrug,
    String? image,
    double? price,
    int? quantity,
    //String? date,
  }) {
    return Product(
      namedrug: namedrug ?? this.namedrug,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      //enddate: enddate ?? this.enddate,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      namedrug: json['namedrug'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'] ?? 1,
      //enddate: json['enddate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namedrug': namedrug,
      'image': image,
      'price': price,
      'quantity': quantity,
      //'date': enddate,
    };
  }
}
