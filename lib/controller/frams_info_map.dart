import 'package:farmfeeders/models/FarmInfoModel/FarmInfoModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FramsInfoMap extends GetxController {
  FarmInfoAddressModel farmInfoAddressModel =
      FarmInfoAddressModel(farmCount: 0, farms: []);
  RxInt selectedAddressIndex = 0.obs;
  List<TextEditingController> addressList = [];

  TextEditingController addressController = TextEditingController();
  TextEditingController streetTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController provinceTextEditingController = TextEditingController();
  TextEditingController postalCodeTextEditingController =
      TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();

  @override
  void dispose() {
    streetTextEditingController.dispose();
    cityTextEditingController.dispose();
    provinceTextEditingController.dispose();
    postalCodeTextEditingController.dispose();
    countryTextEditingController.dispose();
    super.dispose();
  }
}
