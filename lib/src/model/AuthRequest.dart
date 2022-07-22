class AuthRequest {
  String thirdPartyId;

  AuthRequest({required this.thirdPartyId});

  Map<String, dynamic> toJson() {
    return {
      "thirdPartyId": this.thirdPartyId.trim(),
    };
  }
}
