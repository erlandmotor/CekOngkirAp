import 'package:check_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Kurir extends GetView<HomeController> {
  const Kurir({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      clearButtonProps: ClearButtonProps(isVisible: true),
      popupProps: PopupProps.bottomSheet(
        itemBuilder: (context, item, isSelected) => Container(
          padding: EdgeInsets.all(20),
          child: Text(
            "${item["name"]}",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      items: [
        {
          "code": "jne",
          "name": "Jalur Nugraha Ekakurir (JNE)",
        },
        {
          "code": "tiki",
          "name": "Titipan Kilat",
        },
        {
          "code": "pos",
          "name": "POS INDONESIA",
        },
      ],
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: "Tipe Kurir",
        ),
      ),
      itemAsString: (item) => item["code"],
      onChanged: (value) {
        if (value != null) {
          print("${value!["code"]}");
          controller.kurir.value = value["code"];
        } else {
          controller.kurir.value = "";
        }
        controller.showButton();
      },
    );
  }
}
