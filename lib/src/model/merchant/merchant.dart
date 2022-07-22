class Merchant {
  String id;
  String userId;
  String name;
  String location;
  double rating;
  String logoUrl;
  String? createDate;
  String? lastUpdate;
  String email;
  String phone;
  String taxNo;
  String regNo;

  Merchant(
      {this.id = "",
      this.userId = "",
      this.name = "",
      this.location = "",
      this.rating = 0,
      this.logoUrl = "",
      this.createDate = "",
      this.lastUpdate = "",
      this.email = "",
      this.phone = "",
      this.taxNo = "",
      this.regNo = ""}) {}

  Merchant.fromJson(dynamic json)
      : id = json["id"],
        userId = json["userId"],
        name = json["name"],
        location = json["location"],
        rating = json["rating"],
        logoUrl = json["logoUrl"],
        createDate = json["createDate"],
        lastUpdate = json["lastUpdate"],
        email = json["email"],
        phone = json["phone"],
        taxNo = json["taxNo"],
        regNo = json["regNo"];

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["userId"] = userId;
    map["name"] = name;
    map["location"] = location;
    map["rating"] = rating;
    map["logoUrl"] = logoUrl;
    // map["createDate"] = _createDate;
    // map["lastUpdate"] = _lastUpdate;
    map["email"] = email;
    map["phone"] = phone;
    map["taxNo"] = taxNo;
    map["regNo"] = regNo;
    return map;
  }
}
