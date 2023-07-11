import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/home_controller.dart';
import '../../province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({
    super.key,
    required this.tipe,
  });

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownSearch<Province>(
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
                labelText:
                    tipe == "asal" ? "Provinsi Asal" : "Provinsi Tujuan")),
        clearButtonProps: ClearButtonProps(isVisible: true),
        asyncItems: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http
                .get(url, headers: {"key": "06bf2243ac5f4417205f7db6e75d0529"});

            var data = json.decode(response.body) as Map<String, dynamic>;
            var status = data["rajaongkir"]["status"]["code"];
            if (status != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }
            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (e) {
            print(e);
            return List<Province>.empty();
          }
        },
        popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Cari provinsi ...",
              ),
            ),
            itemBuilder: (context, item, isSelected) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "${item.province}",
                ),
              );
            }),
        itemAsString: (item) => item.province,
        onChanged: (Province? data) {
          if (data != null) {
            print(data!.province);

            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = false;
              controller.provAsalID.value = int.parse(data.provinceId);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provTujuanID.value = int.parse(data.provinceId);
            }
          } else {
            print("Tidak memilih apapun");
            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = true;
              controller.provAsalID.value = 0;
              controller.kotaAsalID.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provTujuanID.value = 0;
              controller.kotaTujuanID.value = 0;
            }
          }
          controller.showButton();
        },
      ),
    );
  }
}
