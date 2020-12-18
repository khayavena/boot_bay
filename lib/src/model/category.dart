class Category {
  String id;
  String merchantId;
  String name;
  bool isSelected;
  String image;
  List<Category> categories;

  bool get hasChildren => categories != null && categories.isNotEmpty;

  Category({this.id, this.merchantId, this.name, this.categories, this.isSelected = false});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categories:
          json['categories'] != null ? (json['categories'] as List).map((i) => Category.fromJson(i)).toList() : null,
      id: json['id'],
      merchantId: json['merchantId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['merchantId'] = this.merchantId;
    data['name'] = this.name;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) => other is Category && other.id == id;

  @override
  int get hashCode => super.hashCode;
}
