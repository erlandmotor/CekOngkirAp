import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../city_model.dart';
import '../../controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    super.key,
    required this.provID,
    required this.tipe,
  });

  final int provID;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownSearch<City>(
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                labelText: tipe == "asal"
                    ? "Kota / Kabupaten Asal"
                    : "Kota / Kabupaten Tujuan")),
        clearButtonProps: ClearButtonProps(isVisible: true),
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provID");

          try {
            final response = await http
                .get(url, headers: {"key": "06bf2243ac5f4417205f7db6e75d0529"});

            var data = json.decode(response.body) as Map<String, dynamic>;
            var status = data["rajaongkir"]["status"]["code"];
            if (status != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }
            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (e) {
            print(e);
            return List<City>.empty();
          }
        },
        popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Cari kota / kab ...",
              ),
            ),
            itemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "${item.type} ${item.cityName}",
                ),
              );
            }),
        itemAsString: (item) => item.type! + " " + item.cityName!,
        onChanged: (City? data) {
          if (data != null) {
            if (tipe == "asal") {
              print("Kota / Kabupaten Asal : ${data!.cityName}");
              controller.kotaAsalID.value = int.parse(data.cityId!);
            } else {
              print("Kota / Kabupaten Tujuan : ${data!.cityName}");
              controller.kotaTujuanID.value = int.parse(data.cityId!);
            }
          } else {
            if (tipe == "asal") {
              print("Tidak memilih asal apapun");
              controller.kotaAsalID.value = 0;
            } else {
              print("Tidak memilih tujuan apapun");
              controller.kotaTujuanID.value = 0;
            }
          }
        },
      ),
    );
  }
}
