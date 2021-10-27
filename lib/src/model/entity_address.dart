class EntityAddress {
  String id;
  String parentId;
  String address;
  String type;
  double latitude;
  double longitude;

  EntityAddress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parentId = json['parentId'],
        address = json['address'],
        type = json['type'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  EntityAddress({this.id, this.parentId, this.address, this.type, this.latitude, this.longitude});

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "address": address,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
      };
}
