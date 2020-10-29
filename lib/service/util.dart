

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unlimit_list/service/constant.dart';
import 'package:unlimit_list/model/json/person.dart';


Future<http.Response> loadPersons() async {
    int count = REQUEST_LIMIT;
    return http.get("https://randomuser.me/api?results=$count");
}

List<Person> parsePersons(String response) {
    final parsed = new Map<String, dynamic>.from(json.decode(response));
    List<Person> result = parsed['results'].map<Person>((json) => Person.fromJson(json)).toList();
    return result;
}

Future<List<Person>> loadNewPersons() async {
    http.Response response = await loadPersons();
    if ( response.statusCode == 200 ) {
        return parsePersons(response.body);
    } else {
        return Future.error("Bad response");
        // throw Exception('Bad response');
    }
}