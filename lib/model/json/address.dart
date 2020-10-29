



import 'package:unlimit_list/model/json/street.dart';

class Address {
    Street street;
    String city;
    String postcode;

    Address({this.street, this.city, this.postcode});

    factory Address.fromJson(Map<String, dynamic> json) {
        return Address (
            street: Street.fromJson(json['street']),
            city: json['city'] as String,
            //postcode: json['postcode'] as String,
        );
    }

    @override
    String toString() {
        // return "${this.street}, ${this.city} ${this.postcode}";
        return "${this.street}, ${this.city}";
    }
}