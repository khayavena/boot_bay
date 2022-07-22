class BinData {
  String commercial;
  String countryOfIssuance;
  String debit;
  String durbinRegulated;
  String healthcare;
  String issuingBank;
  String payroll;
  String prepaid;
  String productId;

  BinData(
      {required this.commercial,
      required this.countryOfIssuance,
      required this.debit,
      required this.durbinRegulated,
      required this.healthcare,
      required this.issuingBank,
      required this.payroll,
      required this.prepaid,
      required this.productId});

  factory BinData.fromJson(Map<String, dynamic> json) {
    return BinData(
      commercial: json['commercial'],
      countryOfIssuance: json['countryOfIssuance'],
      debit: json['debit'],
      durbinRegulated: json['durbinRegulated'],
      healthcare: json['healthcare'],
      issuingBank: json['issuingBank'],
      payroll: json['payroll'],
      prepaid: json['prepaid'],
      productId: json['productId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commercial'] = this.commercial;
    data['countryOfIssuance'] = this.countryOfIssuance;
    data['debit'] = this.debit;
    data['durbinRegulated'] = this.durbinRegulated;
    data['healthcare'] = this.healthcare;
    data['issuingBank'] = this.issuingBank;
    data['payroll'] = this.payroll;
    data['prepaid'] = this.prepaid;
    data['productId'] = this.productId;
    return data;
  }
}
