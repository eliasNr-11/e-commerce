import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
    final String? userId;
    final String? paymentMethod;
    final List<Item>? items;
    final double? totalPrice;
    final String? deliveryAddress;
    final String? status;
    final Timestamp? orderDate;

    Order({
        this.userId,
        this.paymentMethod,
        this.items,
        this.totalPrice,
        this.deliveryAddress,
        this.status,
        this.orderDate,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        userId: json["userId"],
        paymentMethod: json["paymentMethod"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        totalPrice: json["totalPrice"]?.toDouble(),
        deliveryAddress: json["deliveryAddress"],
        status: json["status"],
        orderDate: json["orderDate"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "paymentMethod": paymentMethod,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "deliveryAddress": deliveryAddress,
        "status": status,
        "orderDate": orderDate,
    };
}

class Item {
    final String? productId;
    final String? name;
    final int? quantity;
    final double? price;
    final String? imageUrl;

    Item({
        this.productId,
        this.name,
        this.quantity,
        this.price,
        this.imageUrl,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["productId"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"]?.toDouble(),
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "quantity": quantity,
        "price": price,
        "imageUrl": imageUrl,
    };
}
