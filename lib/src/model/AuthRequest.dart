class AuthRequest {
  String thirdPartyId;

  AuthRequest({this.thirdPartyId});

  Map<String, dynamic> toJson() {
    return {
      "thirdPartyId": this.thirdPartyId.trim(),
    };
  }
}
