class EntityAddress {
  String? id;
  late String parentId;
  late String address;
  late String type;
  late double latitude;
  late double longitude;
  late bool selected;

  EntityAddress();

  EntityAddress.copy(
      {this.id,
      required this.parentId,
      required this.address,
      required this.type,
      required this.latitude,
      required this.longitude,
      this.selected = false});

  EntityAddress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parentId = json['parentId'],
        address = json['address'],
        type = json['type'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        selected = json['selected'] ?? false;

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
