import 'package:check_ongkir/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeratBadan extends GetView<HomeController> {
  const BeratBadan({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.beratC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text("Berat Barang"),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => controller.ubahBerat(value),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: DropdownSearch<String>(
            popupProps: PopupProps.bottomSheet(
              showSelectedItems: true,
              showSearchBox: true,
            ),
            items: [
              "ton",
              "kwintal",
              "ons",
              "lbs",
              "pound",
              "kg",
              "hg",
              "dag",
              "gram",
              "dg",
              "cg",
              "mg",
            ],
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Satuan",
                hintText: "",
              ),
            ),
            onChanged: (value) => controller.ubahSatuan(value!),
            selectedItem: "gram",
          ),
        )
      ],
    );
  }
}
