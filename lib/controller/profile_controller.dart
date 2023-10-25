import 'package:farmfeeders/models/ProfileModel/profile_info_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<ProfileInfoModel> profileInfoModel = ProfileInfoModel(
          data: Data(emailAddress: "", userName: "", phoneNumber: ""))
      .obs;
}
