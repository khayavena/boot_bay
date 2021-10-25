class SysUser {
  bool active;
  String contactNo;
  String customerId;
  String dateOfBirth;
  String email;
  String firstName;
  String fullName;
  String id;
  String lastName;
  bool marchant;
  int parentId;
  String password;
  String role;
  String thirdPartyId;

  SysUser(
      {this.active,
      this.contactNo,
      this.customerId,
      this.dateOfBirth,
      this.email,
      this.firstName,
      this.fullName,
      this.id,
      this.lastName,
      this.marchant,
      this.parentId,
      this.password,
      this.role,
      this.thirdPartyId});

  factory SysUser.fromJson(Map<String, dynamic> json) {
    return SysUser(
      active: json['active'],
      contactNo: json['contactNo'] ?? '',
      customerId: json['customerId'],
      dateOfBirth: json['dateOfBirth'] ?? null,
      email: json['email'],
      firstName: json['firstName'],
      fullName: json['fullName'],
      id: json['id'],
      lastName: json['lastName'],
      marchant: json['marchant'],
      thirdPartyId: json['thirdPartyId'],
      parentId: json['parentId'],
      password: json['password'] ?? '',
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['customerId'] = this.customerId;
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    data['lastName'] = this.lastName;
    data['marchant'] = this.marchant;
    data['parentId'] = this.parentId;
    data['role'] = this.role;
    data['thirdPartyId'] = this.thirdPartyId;
    if (this.contactNo != null) {
      data['contactNo'] = this.contactNo;
    }
    if (this.dateOfBirth != null) {
      data['dateOfBirth'] = this.dateOfBirth;
    }
    if (this.password != null) {
      data['password'] = this.password;
    }
    return data;
  }
}
