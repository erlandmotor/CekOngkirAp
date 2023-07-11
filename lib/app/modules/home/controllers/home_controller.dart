import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var hiddenKotaAsal = true.obs;
  var hiddenKotaTujuan = true.obs;
  var hiddenButton = true.obs;
  var provAsalID = 0.obs;
  var provTujuanID = 0.obs;
  var kotaAsalID = 0.obs;
  var kotaTujuanID = 0.obs;
  var kurir = "".obs;
  late TextEditingController beratC;

  double berat = 0.0;
  String satuan = "gram";

  void showButton() {
    print(
        "KotaAsal $kotaAsalID KotaTujuan $kotaTujuanID berat $berat Kurir $kurir");
    if (kotaAsalID.value != 0 &&
        kotaTujuanID.value != 0 &&
        berat > 0 &&
        kurir != "") {
      hiddenButton.value = false;
    } else {
      hiddenButton.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2284.62;
        break;
      case "pound":
        berat = berat * 2284.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    print("$berat gram");
    showButton();
  }

  void ubahSatuan(String value) {
    berat = double.tryParse(beratC.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "ons":
        berat = berat * 100;
        break;
      case "lbs":
        berat = berat * 2284.62;
        break;
      case "pound":
        berat = berat * 2284.62;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "hg":
        berat = berat * 100;
        break;
      case "dag":
        berat = berat * 10;
        break;
      case "gram":
        berat = berat;
        break;
      case "dg":
        berat = berat / 10;
        break;
      case "cg":
        berat = berat / 100;
        break;
      case "mg":
        berat = berat / 1000;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    print("$berat gram");
    showButton();
  }

  void ongkosKirim() async {
    try {
      Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
      final response = await http.post(
        url,
        body: {
          "origin": "$kotaAsalID",
          "destination": "$kotaTujuanID",
          "weight": "$berat",
          "courier": "$kurir",
        },
        headers: {
          "key": "06bf2243ac5f4417205f7db6e75d0529",
          "content-type": "application/x-www-form-urlencoded",
        },
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      var result = data["rajaongkir"]["results"];
      print(result);
    } catch (err) {
      print(err);
      Get.defaultDialog(
        title: "Terjadi Kesalahanan",
        middleText: err.toString(),
      );
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    beratC = TextEditingController(text: "$berat");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    beratC.dispose();
    super.onClose();
  }
}
