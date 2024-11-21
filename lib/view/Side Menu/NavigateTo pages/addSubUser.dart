import 'package:farmfeeders/Utils/sized_box.dart';
import 'package:farmfeeders/Utils/utils.dart';
import 'package:farmfeeders/common/CommonTextFormField.dart';
import 'package:farmfeeders/common/custom_appbar.dart';
import 'package:farmfeeders/common/custom_button.dart';
import 'package:farmfeeders/common/limit_range.dart';
import 'package:farmfeeders/controller/sub_user_controller.dart';
import 'package:farmfeeders/view_models/SubUserApi.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/AddressModel/search_responce_model.dart';
import '../../placeServices/place_services.dart';
import '../../search_address_details.dart';

class addSubUser extends StatefulWidget {
  const addSubUser({super.key});

  @override
  State<addSubUser> createState() => _addSubUserState();
}

class _addSubUserState extends State<addSubUser> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final dob = TextEditingController();
  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  String? subuserdatecontroller;
  DateTime? _selectedDate;
  List<Prediction> searchResults = [];
  bool searchClear = true;
  final placesService = PlacesService();
  List<int> permissionList = [];
  SubUserController subUserController = Get.put(SubUserController());

  void _addSubUser() {
    Utils.loader();
    analytics.logEvent(
      name: 'add_sub_user',
      parameters: {
        'user_name': name.text,
        'permissions_count': permissionList.length,
      },
    );

    var data = {
      "name": name.text,
      "dob": subuserdatecontroller,
      "phone_number": phone.text,
      "email": email.text,
      "password": password.text,
      "permissions": permissionList,
      "address": address.text,
    };

    SubuserApi().addSubUserApi(data);
  }

  void _updateSubUser() {
    Utils.loader();
    analytics.logEvent(
      name: 'update_sub_user',
      parameters: {
        'user_id': subUserController.subUserData.id!,
        // 'permissions_changed': !listEquals(
        //     permissionList, subUserController.subUserData.permissions),
      },
    );

    var data = {
      "id": subUserController.subUserData.id,
      "name": name.text,
      "dob": subuserdatecontroller,
      "phone_number": phone.text,
      "email": email.text,
      "password": password.text,
      "permissions": permissionList,
      "address": address.text,
    };
    if (password.text.isEmpty) {
      data.remove("password");
    }

    SubuserApi().updateSubUserApi(data);
  }

  var args = Get.arguments;
  bool isEdit = false;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    isEdit = args["isEdit"];
    if (isEdit) {
      name.text = subUserController.subUserData.name!;
      subuserdatecontroller = subUserController.subUserData.dob!;
      _selectedDate = DateTime.parse(subUserController.subUserData.dob!);
      dob.text = subUserController.subUserData.dob!;
      phone.text = subUserController.subUserData.phoneNumber!;
      email.text = subUserController.subUserData.email!;
      address.text = subUserController.subUserData.address!;
      if (subUserController.subUserData.permissions!.contains(11)) {
        isChecked = true;
      }
      if (subUserController.subUserData.permissions!.contains(13)) {
        isChecked1 = true;
      }
      if (subUserController.subUserData.permissions!.contains(14)) {
        isChecked2 = true;
      }

      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])(?=.{8,})',
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
              margin: const EdgeInsets.only(top: 15),
              child: customAppBar(
                  text: isEdit ? "Update Sub User" : "Add Sub User")),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Full Name",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Full Name';
                        }
                        if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                          return 'Please enter a valid name';
                        }
                        // v2 = true;
                        return null;
                      },
                      leadingIcon:
                          SvgPicture.asset("assets/images/profileimage.svg"),
                      hintText: "Full Name",
                      validatorText: "Please Enter Full Name"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Date Of Birth",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: dob,
                      readonly: true,
                      onTap: () {
                        _subUserDatePicker();
                      },
                      leadingIcon:
                          SvgPicture.asset("assets/images/calender.svg"),
                      hintText: "Date Of Birth",
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Date Of Birth is required';
                        }

                        return null;
                      },
                      validatorText: "Date Of Birth is required"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9),
                      ],
                      textEditingController: phone,
                      texttype: TextInputType.phone,
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
                      hintText: "Phone",
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
                      validatorText: "Please Enter phone Number"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      textEditingController: email,
                      leadingIcon: SvgPicture.asset("assets/images/mail.svg"),
                      hintText: "Email Address",
                      validator: (value) {
                        if (value == value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // v4 = true;
                        return null;
                      },
                      validatorText: "Please Enter Email Address"),
                  SizedBox(
                    height: 20.h,
                  ),
                  isEdit
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              textEditingController: password,
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/password.svg"),
                              hintText: "",
                              validator: (value) {
                                if (!isEdit) {
                                  if (value == value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (!passwordRegex.hasMatch(value!)) {
                                    return 'Password must be at least 8 characters long, '
                                        'include one uppercase letter, one lowercase letter, '
                                        'one number, and one special character.';
                                  }
                                }
                                if (isEdit && password.text.isNotEmpty) {
                                  if (!passwordRegex.hasMatch(value!)) {
                                    return 'Password must be at least 8 characters long, '
                                        'include one uppercase letter, one lowercase letter, '
                                        'one number, and one special character.';
                                  }
                                }

                                return null;
                              },
                              validatorText: "",
                              isInputPassword: true,
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextFormField(
                      isAddress: true,
                      suffixIcon: address.text.isEmpty
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                print('clear search done');
                                address.clear();

                                //FocusScope.of(context).unfocus();
                                setState(() {});
                                //  _form.currentState?.reset();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Icon(
                                  Icons.cancel_sharp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                      onChanged: (value) async {
                        searchClear = value.isEmpty;
                        await placesService
                            .getAutocomplete(value)
                            .then((value) {
                          final searchResponse =
                              searchAddressListFromJson(value);

                          searchResults = searchResponse.predictions!;
                        });
                        setState(() {});
                      },
                      textEditingController: address,
                      leadingIcon:
                          SvgPicture.asset("assets/images/location.svg"),
                      hintText: "Address",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter address';
                        }
                        return null;
                      },
                      validatorText: "please Enter Address"),
                  SizedBox(
                    height: (!searchClear && address.text.isNotEmpty) ? 12 : 0,
                  ),
                  Visibility(
                    visible: !searchClear && address.text.isNotEmpty,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.91,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                dense: true,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                contentPadding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                title: Text(
                                  // change
                                  searchResults[index].description.toString(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                onTap: () async {
                                  setState(() {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    searchClear = true;
                                    String id =
                                        searchResults[index].placeId.toString();
                                    placesService
                                        .getPlace(id)
                                        .then((value) async {
                                      final searchResponse =
                                          searchAddressDetailsFromJson(value);

                                      address.text = searchResponse
                                          .result!.formattedAddress!;
                                    });
                                  });
                                },
                              ),
                              const Divider(
                                color: Colors.black,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Permission",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Orders",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF4D4D4D)),
                          ),
                          const Spacer(),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF0E5F02),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                                analytics.logEvent(
                                  name: 'permission_changed',
                                  parameters: {
                                    'permission': "Orders",
                                    'enabled': value,
                                  },
                                );
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Livestock",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF4D4D4D)),
                          ),
                          const Spacer(),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF0E5F02),
                            value: isChecked1,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked1 = value!;
                                analytics.logEvent(
                                  name: 'permission_changed',
                                  parameters: {
                                    'permission': "Livestock",
                                    'enabled': value,
                                  },
                                );
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    height: 32,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Feed",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xFF4D4D4D)),
                          ),
                          const Spacer(),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF0E5F02),
                            value: isChecked2,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked2 = value!;
                                analytics.logEvent(
                                  name: 'permission_changed',
                                  parameters: {
                                    'permission': "Feed",
                                    'enabled': value,
                                  },
                                );
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  customButton(
                    text: isEdit ? "Update" : "Submit",
                    onTap: () {
                      final FormState? form = _form.currentState;
                      if (form != null && form.validate()) {
                        permissionList.clear();
                        if (isChecked) {
                          permissionList.add(11);
                        }
                        if (isChecked1) {
                          permissionList.add(13);
                        }
                        if (isChecked2) {
                          permissionList.add(14);
                        }
                        if (permissionList.isNotEmpty) {
                          if (isEdit) {
                            _updateSubUser();
                          } else {
                            _addSubUser();
                          }
                        } else {
                          utils.showToast("Select atleast one permission");
                        }
                      }
                    },
                  ),
                  sizedBoxHeight(58.h)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _subUserDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    DateTime eighteenYearsAgo =
        DateTime.now().subtract(const Duration(days: 365 * 18));
    showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(1922),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return setState(() {
          subuserdatecontroller = '';
          dob.text = "";
        });
      }

      if (pickedDate.isBefore(eighteenYearsAgo)) {
        analytics.logEvent(
          name: 'dob_selected',
          parameters: {'age': DateTime.now().year - pickedDate.year},
        );
        setState(() {
          _selectedDate = pickedDate;
          dob.text =
              "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
          subuserdatecontroller =
              "${_selectedDate!.day.toString()}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString().padLeft(2, '0')}";
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
}
