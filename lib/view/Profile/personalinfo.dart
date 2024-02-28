import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:farmfeeders/Utils/colors.dart';
import 'package:farmfeeders/Utils/custom_button.dart';
import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:farmfeeders/common/limit_range.dart';
import '../../Utils/api_urls.dart';
import '../../Utils/base_manager.dart';
import '../../Utils/utils.dart';
import '../../models/ProfileModel/profile_info_model.dart';
import '../../view_models/ProfileAPI.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //bool editBool = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? _selectedDate;
  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());

  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    List<String> formattedDate = profileController
        .profileInfoModel.value.data!.dateOfBirth!
        .split(" ")[0]
        .split("-");
    String formattedDate1 =
        "${formattedDate[2]}/${formattedDate[1]}/${formattedDate[0]}";
    nameController.text =
        profileController.profileInfoModel.value.data!.userName!;
    phoneController.text =
        profileController.profileInfoModel.value.data!.phoneNumber!;
    emailController.text =
        profileController.profileInfoModel.value.data!.emailAddress!;
    dateController.text = formattedDate1;
    //dgff
    super.initState();
  }

  void uploadData() async {
    Utils.loader();
    MultipartFile imageFile;

    if (editProfileImage.profilePicPath.value.isNotEmpty) {
      imageFile = await MultipartFile.fromFile(
        editProfileImage.profilePicPath.value,
        filename: path.basename(editProfileImage.profilePicPath.value),
      );
    } else {
      if (profileController
          .profileInfoModel.value.data!.profilePhoto!.isEmpty) {
        //
        imageFile = await Utils.assetImageToMultipartFile(
            "assets/default_image.jpg", "profile");
      } else {
        imageFile = await Utils.networkImageToMultipartFile(
          "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}",
        );
      }
    }
    List<String> formattedDate = dateController.text.split("/");
    String formattedDate1 =
        "${formattedDate[0]}-${formattedDate[1]}-${formattedDate[2]}";
    final data = await ProfileAPI().updateProfileApi(map: {
      "name": nameController.text,
      "phone_number": phoneController.text,
      "dob": formattedDate1,
      "email": emailController.text,
      'profile_photo': imageFile,
    });
    if (data.status == ResponseStatus.SUCCESS) {
      ProfileAPI().getProfileInfo().then((value) {
        profileController.profileInfoModel.value =
            ProfileInfoModel.fromJson(value.data);
        utils.showToast("Profile added Successfully!");

        Get.back();
        Get.back(result: true);
      });
    } else {
      Get.back();
      utils.showToast(data.message);
    }
  }

  Future<File> saveFilePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    return File(imagePath).copy(imagePath);
  }

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    DateTime eighteenYearsAgo =
        DateTime.now().subtract(const Duration(days: 365 * 18));
    showDatePicker(
      context: context,
      initialDate: DateTime.parse(profileController
          .profileInfoModel.value.data!.dateOfBirth!
          .split(" ")[0]),
      firstDate: DateTime(1922),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.buttoncolour,
                onPrimary: AppColors.white,
                onSurface: Colors.blueAccent,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.buttoncolour,
                ),
              ),
            ),
            child: child!);
      },
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      if (pickedDate.isBefore(eighteenYearsAgo)) {
        setState(() {
          _selectedDate = pickedDate;
          dateController.text =
              "${_selectedDate!.day.toString()}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year.toString().padLeft(2, '0')}";
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Age Restriction"),
              content: const Text("Sorry, you must be above 18 years age"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  builduploadprofile() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26.r),
          topRight: Radius.circular(26.r),
        ),
      ),
      builder: (context) {
        return Container(
          // height: 180.h,
          margin: EdgeInsets.symmetric(horizontal: 36.w, vertical: 26.h),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Photo',
                  style: TextStyle(
                      color: const Color(0xff444444),
                      fontSize: 22.sp,
                      fontFamily: 'Poppins'),
                ),
                sizedBoxHeight(40.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        editProfileImage.getImage(ImageSource.camera);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 27.r,
                            backgroundColor: const Color(0xff143C6D),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xff444444),
                                fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                    ),
                    sizedBoxWidth(36.w),
                    GestureDetector(
                      onTap: () {
                        editProfileImage.getImage(ImageSource.gallery);
                        Get.back();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 27.r,
                            backgroundColor: const Color(0xff143C6D),
                            child: Icon(
                              Icons.image_outlined,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'Gallery',
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xff444444),
                                fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                    ),
                    sizedBoxWidth(36.w),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Utils.loader();
                        ProfileAPI().deleteProfileImageAPI().then((value) {
                          ProfileAPI().getProfileInfo().then((value) {
                            profileController.profileInfoModel.value =
                                ProfileInfoModel.fromJson(value.data);
                            utils.showToast("Profile Deleted Sucessfully");
                            Get.back();
                            setState(() {});
                          });
                        });
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 27.r,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: 30.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xff444444),
                                fontFamily: 'Poppins'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      radius: 20.h,
                      backgroundColor: const Color(0XFFF1F1F1),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 25.h,
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.w),
                  Text(
                    "Personal Information",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(40.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Obx(
                                  () => ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(60.r),
                                      child: editProfileImage
                                                  .profilePicPath.value !=
                                              ''
                                          ? Image(
                                              image: FileImage(File(
                                                  editProfileImage
                                                      .profilePicPath.value)),
                                              fit: BoxFit.cover,
                                              width: 200.w,
                                              height: 200.h,
                                            )
                                          : profileController
                                                  .profileInfoModel
                                                  .value
                                                  .data!
                                                  .profilePhoto!
                                                  .isEmpty
                                              ? Image.asset(
                                                  "assets/default_image.jpg")
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      builduploadprofile();
                                    },
                                    child: Material(
                                      elevation: 1,
                                      shape: const CircleBorder(),
                                      child: CircleAvatar(
                                          radius: 16.5.r,
                                          backgroundColor:
                                              const Color(0XFF0E5F02),
                                          child: SvgPicture.asset(
                                            "assets/images/camera-svgrepo-com.svg",
                                            width: 20.w,
                                            height: 17.h,
                                          )
                                          // Icon(
                                          //   Icons.edit_outlined,
                                          //   color: Color(0xffCCCCCC),
                                          // ),
                                          ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        sizedBoxHeight(31.h),
                        Text(
                          "Full Name",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              color: const Color(0XFF141414)),
                        ),
                        CustomTextFormField(
                          textEditingController: nameController,
                          hintText: 'Enter Full Name',
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          validatorText: 'Please enter full name',
                          texttype: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter full name";
                            }
                            return null;
                          },
                        ),
                        sizedBoxHeight(21.h),
                        Text(
                          "Date Of Birth",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              color: const Color(0XFF141414)),
                        ),
                        Personaldatepicker(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Select Date of Birth";
                            }
                            return null;
                          },
                          datecontroller: dateController,
                          ontap: () => _presentDatePicker(),
                        ),
                        sizedBoxHeight(21.h),
                        Text(
                          "Contact Number",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              color: const Color(0XFF141414)),
                        ),
                        CustomTextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(9),
                            //  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          textEditingController: phoneController,
                          hintText: 'Enter Contact Number',
                          texttype: TextInputType.number,
                          validatorText: 'Please enter contact number',
                          leadingIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset("assets/images/phone.svg"),
                              sizedBoxWidth(5.w),
                              Text(
                                "+353",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                ),
                              )
                            ],
                          ),
                          validator: (value) {
                            if (value == value.isEmpty) {
                              return 'Mobile number is required';
                            } else if (!value.toString().startsWith("8")) {
                              return 'Enter a valid mobile number starting with 8';
                            } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{9}$)')
                                .hasMatch(value)) {
                              return 'Enter valid mobile number';
                            }
                            // v3 = true;
                            return null;
                          },
                        ),
                        sizedBoxHeight(21.h),
                        Text(
                          "Email Address",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18.sp,
                              color: const Color(0XFF141414)),
                        ),
                        CustomTextFormField(
                          readonly: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                          ],
                          textEditingController: emailController,
                          hintText: 'Enter Email Address',
                          validatorText: 'Please enter email address',
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@') ||
                                !value.contains('.')) {
                              return "Please enter valid email address";
                            }
                            return null;
                          },
                        ),
                        sizedBoxHeight(38.h),
                        CustomButton(
                            text: "Save",
                            onTap: () {
                              final isValid = _formKey.currentState?.validate();
                              if (isValid!) {
                                uploadData();
                              } else {
                                Flushbar(
                                  message: "Please fill all fields",
                                  duration: const Duration(seconds: 3),
                                ).show(context);
                              }
                            }),
                        sizedBoxHeight(79.h),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileImageController extends GetxController {
  RxString profilePicPath = "".obs;

  void getImage(ImageSource imgSource) async {
    final ImagePicker picker = ImagePicker();
    print('profilePicPath $profilePicPath');
    final XFile? pickedImg = await picker.pickImage(source: imgSource);
    if (pickedImg != null) {
      final CroppedFile? croppedImg = await ImageCropper().cropImage(
          sourcePath: pickedImg.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressFormat: ImageCompressFormat.jpg,
          maxHeight: 512,
          maxWidth: 512,
          compressQuality: 100,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "Crop Image",
              toolbarColor: Get.theme.appBarTheme.backgroundColor,
              // toolbarWidgetColor: ColorConstants.kWhite,
              backgroundColor: Colors.black,
              activeControlsWidgetColor: Colors.red,
              // initAspectRatio: CropAspectRatioPreset.original,
              cropFrameColor: Colors.white,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ]);
      if (croppedImg != null) {
        // profilPic = croppedImg.path;
        profilePicPath.value = croppedImg.path;
        // Get.back();
      }
    }
  }
}

class Personaldatepicker extends StatelessWidget {
  Personaldatepicker({
    Key? key,
    required this.datecontroller,
    required this.ontap,
    this.validator,
    this.inputFormatters,
    this.textEditingController,
    this.leadingIcon,
    this.onTap,
    this.eyeIcon = false,
    this.onChanged,
    this.suffixIcon,
    this.readonly = false,
    this.isInputPassword = false,
    this.outlineColor = const Color(0xFFFFB600),
    // this.keyboardType,
    this.suffixIconConstraints,
    this.texttype,
  }) : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;
  final dynamic validator;
  final TextEditingController? textEditingController;
  final Widget? leadingIcon;
  final bool eyeIcon;
  final Widget? suffixIcon;
  final bool isInputPassword;
  void Function(String)? onChanged;
  void Function()? onTap;
  final bool readonly;
  final dynamic inputFormatters;
  final Color outlineColor;
  final BoxConstraints? suffixIconConstraints;

  final TextInputType? texttype;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 16.sp,
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: datecontroller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: const Color(0xFF3B3F43),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 14.sp),
          contentPadding: EdgeInsets.all(17.h),
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: CircleAvatar(
              radius: 20.h,
              backgroundColor: AppColors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: IconButton(
                    icon: const Icon(
                      Icons.date_range,
                      color: Color(0xFF0E5F02),
                    ),
                    onPressed: () {
                      ontap();
                    },
                  ),
                ),
              ),
            ),
          ),
          hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode
                  ? Colors.white
                  : const Color(0xFF4D4D4D).withOpacity(0.3)),
          hintText: "Select Date"),
    );
  }
}
