class Product {
  String categoryId;
  String category;
  String creation;
  String description;
  String id;
  String image;
  String lastUpdate;
  String merchantId;
  String name;
  double price;
  double scoring;
  bool isWeighed;
  bool isLiked;
  bool isSelected;

  Product(
      {this.categoryId,
      this.creation,
      this.description,
      this.id,
      this.image,
      this.lastUpdate,
      this.merchantId,
      this.name,
      this.price,
      this.scoring,
      this.isWeighed,
      this.isLiked,
      this.isSelected});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        categoryId: json['categoryId'],
        creation: json['creation'],
        description: json['description'],
        id: json['id'],
        image: json['imageUrl'],
        lastUpdate: json['lastUpdate'],
        merchantId: json['merchantId'],
        name: json['name'],
        price: json['price'] as double,
        scoring: json['scoring'],
        isWeighed: json['wieghed'],
        isLiked: json["isLiked"] ?? false,
        isSelected: json["isLiked"] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['category'] =  'Powered by VDI';
    data['creation'] = this.creation;
    data['description'] = this.description;
    data['id'] = this.id;
    data['imageUrl'] = this.image;
    data['lastUpdate'] = this.lastUpdate;
    data['merchantId'] = this.merchantId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['scoring'] = this.scoring;
    data['wieghed'] = this.isWeighed;
    data['isliked'] = isLiked;
    data['isSelected'] = isSelected;

    return data;
  }
}
