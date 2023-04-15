import 'dart:convert';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/ClassModules/cmGlobalVariables.dart';
import 'package:login/ServiceLayer/Sl_CountriesList.dart';
import 'package:login/ServiceLayer/Sl_WebToken.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

import '../../ClassModules/cmCryptography.dart';
import '../../ServiceLayer/Sl_CitiesList.dart';
import '../../ServiceLayer/Sl_UserCreate.dart';
import '../Model/ApiModels/ModCities.dart';
import '../Model/ApiModels/ModCountry.dart';
import '../Model/ApiModels/ModErrorLog.dart';
import '../Model/ApiModels/ModUser.dart';

class VmSignUp extends GetxController {
  RxBool l_autoValidate = false.obs;

  RxString l_PrFullName = ''.obs;

  String get Pr_txtFullname_Text {
    return l_PrFullName.value;
  }

  set Pr_txtFullname_Text(String value) {
    l_PrFullName.value = value;
  }

  String? Pr_validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  RxString l_PrEmail = ''.obs;

  String get Pr_txtemail_Text {
    return l_PrEmail.value;
  }

  set Pr_txtemail_Text(String value) {
    l_PrEmail.value = value;
  }

  String? Pr_validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  RxString l_PrPassword = ''.obs;

  String get Pr_txtpassword_Text {
    return l_PrPassword.value;
  }

  set Pr_txtpassword_Text(String value) {
    l_PrPassword.value = value;
  }

  String? Pr_validatepasword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  RxString l_PrConfirmPassword = ''.obs;

  String get Pr_txtconfirmpassword_Text {
    return l_PrConfirmPassword.value;
  }

  set Pr_txtconfirmpassword_Text(String value) {
    l_PrConfirmPassword.value = value;
  }

  String? Pr_validateconfirmpass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  RxString l_PrContactNumber = ''.obs;

  String get Pr_txtcontactnumber_Text {
    return l_PrContactNumber.value;
  }

  set Pr_txtcontactnumber_Text(String value) {
    l_PrContactNumber.value = value;
  }

  String? Pr_validateconcotactnumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact number';
    }
    return null;
  }

  RxString l_PrContactCode = ''.obs;

  String get Pr_contactcode_Text {
    return l_PrContactCode.value;
  }

  set Pr_contactcode_Text(String value) {
    l_PrContactCode.value = value;
  }

  String? Pr_validateconcotactcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your contact code';
    }
    return null;
  }

  RxString l_PrSelectedCity = ''.obs;

  String get Pr_selectedcity_Text {
    return l_PrSelectedCity.value;
  }

  set Pr_selectedcity_Text(String value) {
    l_PrSelectedCity.value = value;
  }

  RxString l_PrSelectedCountry = ''.obs;

  String get Pr_selectedcountry_Text {
    return l_PrSelectedCountry.value;
  }

  set Pr_selectedcountry_Text(String value) {
    l_PrSelectedCountry.value = value;
  }

  RxInt l_PrSelectedAutoID = 0.obs;

  int get Pr_selectedautoid_Text {
    return l_PrSelectedAutoID.value;
  }

  set Pr_selectedautoid_Text(int value) {
    l_PrSelectedAutoID.value = value;
  }

  RxBool l_PrisSecurePassword = false.obs;

  RxBool get Pr_boolSecurePassword_wid {
    return l_PrisSecurePassword;
  }

  set Pr_boolSecurePassword_wid(RxBool value) {
    l_PrisSecurePassword = value;
  }

  Rx<File?> G_compressedImage = Rx<File?>(null);
  RxInt G_compressedSize = 0.obs;

  RxString Pr_imageName = RxString('');

  Future<void> Fnc_ValidateLogin() async {
    if (l_PrFullName == null) {
      print("Email req");
    } else if (l_PrPassword == null) {
      print("Pass req");
    } else {}
  }

  Future<bool> FncUserImage() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File compressedImage = await FlutterNativeImage.compressImage(
        pickedFile.path,
        quality: 70,
        targetHeight: 500,
        targetWidth: 500,
      );

      int compressedSize = await compressedImage.length();
      G_compressedSize.value = compressedSize;
      //print('Compressed size: ${compressedSize ~/ 1024} KB');

      Pr_imageName.value = pickedFile.path.split('/').last;
      G_compressedImage.value = compressedImage;

      //ImageExtention
      String imageExtension = path.extension(pickedFile.path);
      print('File extension: $imageExtension');
      cmGlobalVariables.Pb_ImageExt = imageExtension;

      // Convert compressed image to a base64 string
      List<int> bytes = await compressedImage.readAsBytes();
      String base64Image = base64Encode(bytes);
     // print('Base64 image: $base64Image');
      cmGlobalVariables.Pb_ImageString = base64Image;

      return true;
    }

    return false;
  }



  RxList<ModCountry>? l_PrCountriesList = <ModCountry>[].obs;
  ModErrorLog? errorLog;

  Future<Tuple2<List<ModCountry>?, ModErrorLog?>> Fnc_CountryList() async {
    List<ModCountry>? lListCountryList = List<ModCountry>.empty(growable: true);
    ModErrorLog? errorLog = null;
    Tuple2<List<ModCountry>?, ModErrorLog?> responseTuple = await Sl_CountriesList().Fnc_CountriesList();

    lListCountryList = responseTuple.item1;
    errorLog = responseTuple.item2;

    if (lListCountryList == null) {
      return Tuple2(null, errorLog);
    }
    l_PrCountriesList?.addAll(lListCountryList);
    return Tuple2(lListCountryList, errorLog);
  }

  Future<void> Fnc_CountryListdata() async {
    final Tuple2<List<ModCountry>?, ModErrorLog?> lResponse = await Fnc_CountryList();
    if (lResponse.item1 != null && lResponse.item1!.isNotEmpty) {
      print("DataLoaded");
    } else {
      print("NotLoaded");
    }
  }

  RxInt SelectedCity = 0.obs;
  RxInt? SelectedCountry;

  RxList<ModCities>? l_PrCitiesList = <ModCities>[].obs;

  Future<Tuple2<List<ModCities>?, ModErrorLog?>> Fnc_CitiesList() async {
    List<ModCities>? lListCitiesList = List<ModCities>.empty(growable: true);
    ModErrorLog? errorLog = null;
    Tuple2<List<ModCities>?, ModErrorLog?> responseTuple = await Sl_CitiesList().Fnc_CitiesList();

    lListCitiesList = responseTuple.item1;
    errorLog = responseTuple.item2;

    if (lListCitiesList == null) {
      return Tuple2(null, errorLog);
    }
    l_PrCitiesList?.addAll(lListCitiesList);
    return Tuple2(lListCitiesList, errorLog);
  }

  Future<bool> Fnc_CitiesListdata() async {
    final Tuple2<List<ModCities>?, ModErrorLog?> lResponse = await Fnc_CitiesList();
    if (lResponse.item1 != null && lResponse.item1!.isNotEmpty) {
      print("DataLoaded");
      return true;
    } else {
      print("NotLoaded");
      return false;
    }
  }

  List<ModUser> lModuserlist = [];

  FncFillModelData() {
    String uuid = Uuid().v4();
    print(uuid);
    DateTime expiredTime = DateTime.parse("1900-01-01T00:00:00");
    DateTime pkexpiredTime = DateTime.parse("2023-04-13T15:03:39.7042384+05:00");

    ModUser lModUser = ModUser();
    lModUser.Pr_PKGUID = uuid;
    lModUser.Pr_EmailID = Pr_txtemail_Text;
    lModUser.Pr_FullName = Pr_txtFullname_Text;
    lModUser.Pr_CountryDID = Pr_selectedautoid_Text;
    lModUser.Pr_CityDID = cmGlobalVariables.Pb_SelectedCity!;
    lModUser.Pr_Password = cmCryptography().Fnc_Encrypt_AES(Pr_txtpassword_Text);
    lModUser.Pr_IsActivated = false;
    lModUser.Pr_ContactNo = Pr_txtcontactnumber_Text;
    lModUser.Pr_Token = cmGlobalVariables.Pb_Token!;
    lModUser.Pr_ExpiredTime = expiredTime;
    lModUser.Pr_Image = cmGlobalVariables.Pb_ImageString!;
    lModUser.Pr_ImageExt = cmGlobalVariables.Pb_ImageExt! ;
    lModUser.Pr_PackageDID = 0;
    lModUser.Pr_NoOfLicences = 0;
    lModUser.Pr_PerLicenceCost = 0.0;
    lModUser.Pr_PurchasedProductDID = 0;
    lModUser.Pr_PaidAmmount = 0.0;
    lModUser.Pr_PackageExpiryDate = expiredTime;
    lModUser.Pr_PackagePurchaseDate = expiredTime;
    lModUser.Pr_CB = "00000000-0000-0000-0000-000000000000";
    lModUser.Pr_CDate = pkexpiredTime;
    lModUser.Pr_MB = "00000000-0000-0000-0000-000000000000";
    lModUser.Pr_MDate = expiredTime;
    lModUser.Pr_DB = "00000000-0000-0000-0000-000000000000";
    lModUser.Pr_DDate = expiredTime;
    lModUser.Pr_Operation = 0;

    // Add more ModUser models to the list as needed
    lModuserlist.add(lModUser);
  }

  Future<bool> Fnc_UserCreate() async {
    bool result;
    result = await Sl_UserCreate().Fnc_UserCreate();
    if (result == true) {
      print("DataLoaded");
      return true;
    } else {
      print("NotLoaded");
      return false;
    }
  }
}
