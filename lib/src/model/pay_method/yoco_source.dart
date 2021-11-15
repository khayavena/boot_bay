class Source {
  String object;
  String brand;
  int expiryMonth;
  int expiryYear;
  String fingerprint;
  String id;
  String maskedCard;

  Source(
      {this.object,
      this.brand,
      this.expiryMonth,
      this.expiryYear,
      this.fingerprint,
      this.id,
      this.maskedCard});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      object: json['object'] ?? '',
      brand: json['brand'],
      expiryMonth: json['expiryMonth'],
      expiryYear: json['expiryYear'],
      fingerprint: json['fingerprint'],
      id: json['id'],
      maskedCard: json['maskedCard'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object'] = this.object;
    data['brand'] = this.brand;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;
    data['fingerprint'] = this.fingerprint;
    data['id'] = this.id;
    data['maskedCard'] = this.maskedCard;
    return data;
  }
}
