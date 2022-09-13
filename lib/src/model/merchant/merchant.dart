class Merchant {
  String? id;
  late String userId;
  late String name;
  late String location;
  late double rating;
  late String email;
  late String phone;
  late String taxNo;
  late String regNo;

  Merchant();

  Merchant.copy(
      {this.userId = "",
      this.name = "",
      this.location = "",
      this.rating = 0,
      this.email = "",
      this.phone = "",
      this.taxNo = "",
      this.regNo = ""});

  Merchant.update(
      {this.userId = "",
      this.name = "",
      this.location = "",
      this.rating = 0,
      this.email = "",
      this.phone = "",
      this.taxNo = "",
      this.regNo = ""});

  Merchant.fromJson(dynamic json)
      : id = json["id"],
        userId = json["userId"],
        name = json["name"],
        location = json["location"],
        rating = json["rating"],
        email = json["email"],
        phone = json["phone"],
        taxNo = json["taxNo"],
        regNo = json["regNo"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "location": location,
        "rating": 0,
        "email": email,
        "phone": phone,
        "taxNo": taxNo,
        "regNo": regNo
      };
}
