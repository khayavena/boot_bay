class Merchant {
  String _id;
  String _userId;
  String _name;
  String _location;
  double _rating;
  String _logoUrl;
  DateTime _createDate;
  DateTime _lastUpdate;
  String _email;
  String _phone;
  String _taxNo;
  String _regNo;

  String get id => _id;

  String get userId => _userId;

  String get name => _name;

  String get location => _location;

  double get rating => _rating;

  String get logoUrl => _logoUrl;

  DateTime get createDate => _createDate;

  DateTime get lastUpdate => _lastUpdate;

  String get email => _email;

  String get phone => _phone;

  String get taxNo => _taxNo;

  String get regNo => _regNo;

  Merchant(
      {String id,
      String userId,
      String name,
      String location,
      double rating,
      String logoUrl,
      DateTime createDate,
      DateTime lastUpdate,
      String email,
      String phone,
      String taxNo,
      String regNo}) {
    _id = id;
    _userId = userId;
    _name = name;
    _location = location;
    _rating = rating;
    _logoUrl = logoUrl;
    _createDate = createDate;
    _lastUpdate = lastUpdate;
    _email = email;
    _phone = phone;
    _taxNo = taxNo;
    _regNo = regNo;
  }

  Merchant.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["userId"];
    _name = json["name"];
    _location = json["location"];
    _rating = json["rating"];
    _logoUrl = json["logoUrl"];
    _createDate = json["createDate"];
    _lastUpdate = json["lastUpdate"];
    _email = json["email"];
    _phone = json["phone"];
    _taxNo = json["taxNo"];
    _regNo = json["regNo"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["userId"] = _userId;
    map["name"] = _name;
    map["location"] = _location;
    map["rating"] = _rating;
    map["logoUrl"] = _logoUrl;
    map["createDate"] = _createDate;
    map["lastUpdate"] = _lastUpdate;
    map["email"] = _email;
    map["phone"] = _phone;
    map["taxNo"] = _taxNo;
    map["regNo"] = _regNo;
    return map;
  }
}
