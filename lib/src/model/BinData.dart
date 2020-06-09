
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

    BinData({this.commercial, this.countryOfIssuance, this.debit, this.durbinRegulated, this.healthcare, this.issuingBank, this.payroll, this.prepaid, this.productId});

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