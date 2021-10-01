

import 'bin_data.dart';
import 'details.dart';

class PaymentNonce {
    BinData binData;
    String description;
    Details details;
    String nonce;
    String type;
    bool vaulted;

    PaymentNonce({this.binData, this.description, this.details, this.nonce, this.type, this.vaulted});

    factory PaymentNonce.fromJson(Map<String, dynamic> json) {
        return PaymentNonce(
            binData: json['binData'] != null ? BinData.fromJson(json['binData']) : null, 
            description: json['description'], 
            details: json['details'] != null ? Details.fromJson(json['details']) : null, 
            nonce: json['nonce'], 
            type: json['type'], 
            vaulted: json['vaulted'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['nonce'] = this.nonce;
        data['type'] = this.type;
        data['vaulted'] = this.vaulted;
        if (this.binData != null) {
            data['binData'] = this.binData.toJson();
        }
        if (this.details != null) {
            data['details'] = this.details.toJson();
        }
        return data;
    }
}