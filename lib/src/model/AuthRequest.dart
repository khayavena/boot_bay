class AuthRequest {
  String emailAddress;

  String password;

  AuthRequest({this.emailAddress, this.password});

  Map<String, dynamic> toJson() {
    return {
      "emailAddress": this.emailAddress,
      "password": this.password,
    };
  }
}
