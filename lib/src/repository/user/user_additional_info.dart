class GoogleAdditionalInfo {
  String givenName;
  String locale;
  String familyName;
  String picture;
  String aud;
  String azp;
  int exp;
  int iat;
  String iss;
  String sub;
  String name;
  String email;
  bool emailVerified;

  GoogleAdditionalInfo(
      {this.givenName,
      this.locale,
      this.familyName,
      this.picture,
      this.aud,
      this.azp,
      this.exp,
      this.iat,
      this.iss,
      this.sub,
      this.name,
      this.email,
      this.emailVerified});

  GoogleAdditionalInfo.fromJson(Map<String, dynamic> json) {
    givenName = json['given_name'];
    locale = json['locale'];
    familyName = json['family_name'];
    picture = json['picture'];
    aud = json['aud'];
    azp = json['azp'];
    exp = json['exp'];
    iat = json['iat'];
    iss = json['iss'];
    sub = json['sub'];
    name = json['name'];
    email = json['email'];
    emailVerified = json['email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['given_name'] = this.givenName;
    data['locale'] = this.locale;
    data['family_name'] = this.familyName;
    data['picture'] = this.picture;
    data['aud'] = this.aud;
    data['azp'] = this.azp;
    data['exp'] = this.exp;
    data['iat'] = this.iat;
    data['iss'] = this.iss;
    data['sub'] = this.sub;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    return data;
  }
}
