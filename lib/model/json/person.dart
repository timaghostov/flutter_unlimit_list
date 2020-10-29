

import 'package:unlimit_list/model/aitem.dart';
import 'package:unlimit_list/model/json/address.dart';
import 'package:unlimit_list/model/json/full_name.dart';
import 'package:unlimit_list/model/json/photo.dart';


class Person extends AItem {
    Photo photo;
    FullName name;
    Address address;
    String email;
    String phone;

    Person({this.photo, this.name, this.address, this.email, this.phone}) : super( ItemType.Person );

    factory Person.fromJson(Map<String, dynamic> json) {
        return Person (
            photo: Photo.fromJson(json['picture']),
            name: FullName.fromJson(json['name']),
            address: Address.fromJson(json['location']),
            email: json['email'] as String,
            phone: json['phone'] as String,
        );
    }

    @override
    String toString() {
        return "Person { name :: ${this.name}; address :: ${this.address}; email :: ${this.email}; phone :: ${this.phone}; proho :: ${this.photo} }";
    }
}