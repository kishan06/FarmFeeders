import 'package:farmfeeders/models/SetupFarmInfoModel/farm_info_model.dart';
import 'package:get/get.dart';

class SetFarm extends GetxController {
  FarmInfoModel farmInfoModel = FarmInfoModel();
  RxBool isFarmInfoUpdate = false.obs;

  final bool _isSetFarmInfo = false;
  bool get isSetFarmInfo => _isSetFarmInfo;

  final bool _isSetLiveStockInfo = false;
  bool get isSetLiveStockInfo => _isSetLiveStockInfo;

  final bool _isSetFeedInfo = false;
  bool get isSetFeedInfo => _isSetFeedInfo;
}
