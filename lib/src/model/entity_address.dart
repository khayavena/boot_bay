class EntityAddress {
  String id;
  String parentId;
  String address;
  double latitude;
  double longitude;

  EntityAddress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        parentId = json['parentId'],
        address = json['address'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  EntityAddress({this.id, this.parentId, this.address, this.latitude, this.longitude});

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
      };
}
