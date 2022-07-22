class GoogleAdditionalInfo {
  late String givenName;
  late String locale;
  late String familyName;
  late String picture;
  late String aud;
  late String azp;
  late int exp;
  late int iat;
  late String iss;
  late String sub;
  late String name;
  late String email;
  late bool emailVerified;

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
