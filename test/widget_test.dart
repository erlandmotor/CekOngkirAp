import 'dart:convert';

import 'package:check_ongkir/app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Uri url = Uri.parse("https://reqres.in/api/users/7");
  // final responses = await http.get(url);

  // // final data = (json.decode(responses.body) as Map<String, dynamic>)["data"];

  // // print(data["first_name"] + " " + data["last_name"]);

  // final user =
  //     User.fromJson(json.decode(responses.body) as Map<String, dynamic>);

  // print(user.data.firstName + " " + user.data.lastName);

  // Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  // final response =
  //     await http.get(url, headers: {"key": "06bf2243ac5f4417205f7db6e75d0529"});
  // // final response = await http.post(url,
  // //     body: {"name": "Alfi Filsafalasafi", "job": "Flutter Development"});

  // print(response.body);

  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  final response = await http.post(
    url,
    body: {
      "origin": "501",
      "destination": "116",
      "weight": "5",
      "courier": "jne",
    },
    headers: {
      "key": "06bf2243ac5f4417205f7db6e75d0529",
      "content-type": "application/x-www-form-urlencoded",
    },
  );
  print(response.body);
}
