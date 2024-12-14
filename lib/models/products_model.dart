class Product {
    final String? id;
    final String? name;
    final String? description;
    final String? imageUrl;
    final double? price;
    final String? categoryId;
    final String? categoryName;
    final int? discount;
    final bool? isTrending;

    Product({
        this.id,
        this.name,
        this.description,
        this.imageUrl,
        this.price,
        this.categoryId,
        this.categoryName,
        this.discount,
        this.isTrending,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        discount: json["discount"],
        isTrending: json["isTrending"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "imageUrl": imageUrl,
        "price": price,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "discount": discount,
        "isTrending": isTrending,
    };
}
