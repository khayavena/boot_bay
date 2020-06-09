class AuthRequest {
  String emailAdress;

  String password;

  AuthRequest({this.emailAdress, this.password});

  Map<String, dynamic> toJson() {
    return {
      "emailAdress": this.emailAdress,
      "password": this.password,
    };
  }
}
