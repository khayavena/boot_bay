

class Details {
    String bin;
    String cardType;
    String expirationMonth;
    String expirationYear;
    String lastFour;
    String lastTwo;

    Details({this.bin, this.cardType, this.expirationMonth, this.expirationYear, this.lastFour, this.lastTwo});

    factory Details.fromJson(Map<String, dynamic> json) {
        return Details(
            bin: json['bin'], 
            cardType: json['cardType'], 
            expirationMonth: json['expirationMonth'], 
            expirationYear: json['expirationYear'], 
            lastFour: json['lastFour'], 
            lastTwo: json['lastTwo'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bin'] = this.bin;
        data['cardType'] = this.cardType;
        data['expirationMonth'] = this.expirationMonth;
        data['expirationYear'] = this.expirationYear;
        data['lastFour'] = this.lastFour;
        data['lastTwo'] = this.lastTwo;
        return data;
    }
}