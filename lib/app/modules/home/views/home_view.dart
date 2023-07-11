import 'package:check_ongkir/app/modules/home/views/widgets/kurir.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/berat_barang.dart';
import 'widgets/city.dart';
import 'widgets/provinsi.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ongkir Indonesia'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20),
            children: [
              Provinsi(tipe: "asal"),
              Obx(
                () => controller.hiddenKotaAsal.isFalse
                    ? Kota(
                        provID: controller.provAsalID.value,
                        tipe: "asal",
                      )
                    : SizedBox(),
              ),
              Provinsi(tipe: "tujuan"),
              Obx(
                () => controller.hiddenKotaTujuan.isFalse
                    ? Kota(
                        provID: controller.provTujuanID.value,
                        tipe: "tujuan",
                      )
                    : SizedBox(),
              ),
              BeratBadan(),
              SizedBox(height: 5),
              Kurir(),
              SizedBox(height: 50),
              Obx(
                () => controller.hiddenButton.isTrue
                    ? SizedBox()
                    : ElevatedButton(
                        onPressed: () => controller.ongkosKirim(),
                        child: Text("Cek Ongkos Kirim"),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 25),
                        ),
                      ),
              ),

              //untuk kota
            ],
          ),
        ));
  }
}
