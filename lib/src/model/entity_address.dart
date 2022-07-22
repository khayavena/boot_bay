class EntityAddress {
  String id;
  String parentId;
  String address;
  String type;
  double latitude;
  double longitude;
  bool selected;

  EntityAddress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parentId = json['parentId'],
        address = json['address'],
        type = json['type'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        selected = json['selected'] ?? false;

  EntityAddress(
      {this.id = "",
      this.parentId = "",
      this.address = "",
      this.type = "",
      this.latitude = 0,
      this.longitude = 0,
      this.selected = false});

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "address": address,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "selected": selected,
      };
}
