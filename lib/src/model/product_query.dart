class ProductQuery {
  String merchantId;
  List<String> categories = [];
  String token;

  ProductQuery({
    required this.merchantId,
    required this.categories,
    this.token = "",
  });

  Map<String, dynamic> toJson() {
    return {
      "merchantId": this.merchantId,
      "categories": this.categories,
      "token": this.token,
    };
  }
}
