class Category {
    final String? id;
    final String? name;
    final String? imageUrl;

    Category({
        this.id,
        this.name,
        this.imageUrl,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
    };
}
