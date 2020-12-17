class AuthRequest {
  String emailAddress;

  String password;

  AuthRequest({this.emailAddress, this.password});

  Map<String, dynamic> toJson() {
    return {
      "emailAdress": this.emailAddress.trim(),
      "password": this.password.trim(),
    };
  }
}
