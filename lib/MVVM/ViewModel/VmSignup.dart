import 'dart:convert';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/ClassModules/cmGlobalVariables.dart';
import 'package:login/ServiceLayer/Sl_CountriesList.dart';
import 'package:login/ServiceLayer/Sl_DuplicateUser.dart';
import 'package:login/ServiceLayer/Sl_VerifyEmail.dart';
import 'package:path/path.dart' as path;
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

import '../../ClassModules/cmCryptography.dart';
import '../../ServiceLayer/Sl_CitiesList.dart';
import '../../ServiceLayer/Sl_UserCreate.dart';
import '../Model/ApiModels/ModCities.dart';
import '../Model/ApiModels/ModCountry.dart';
import '../Model/ApiModels/ModErrorLog.dart';
import '../Model/ApiModels/ModUser.dart';

class VmSignUp extends GetxController {
  RxBool l_isImageUploaded = false.obs;

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
    ModErrorLog? errorLog;
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
      print("Countries DataLoaded");
    } else {
      print("Countries NotLoaded");
    }
  }

  RxInt SelectedCity = 0.obs;
  RxInt? SelectedCountry;

  RxList<ModCities>? l_PrCitiesList = <ModCities>[].obs;

  Future<Tuple2<List<ModCities>?, ModErrorLog?>> Fnc_CitiesList() async {
    List<ModCities>? lListCitiesList = List<ModCities>.empty(growable: true);
    ModErrorLog? errorLog;
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
      print("Cities Loaded");
      return true;
    } else {
      print("Cities NotLoaded");
      return false;
    }
  }

  List<ModUser> lModuserlist = [];

  FncFillModelData() {
    String uuid = const Uuid().v4();
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
    lModUser.Pr_ImageExt = cmGlobalVariables.Pb_ImageExt!;
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
    lModUser.Pr_Operation = 1;

    // Add more ModUser models to the list as needed
    lModuserlist.add(lModUser);
  }

  Future<bool> Fnc_SendEmail() async {
    try {
      String lHtmlString = "<div style='background-color: #9bd3e9; margin: 0 !important; padding: 0 !important;'><table border='0' cellpadding='0' cellspacing='0' width='100%'><tr bgcolor = '#9bd3e9'><td><div style = 'margin:10px 0px 0px 5px; background-color: #9bd3e9;' ><img src = 'https://i.ibb.co/5hh4wmG/company-logo-96px.png' alt = 'Alternate Text' /></div></td></tr><tr><td bgcolor='#9bd3e9' align='center'><table border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px;'><tr> <td align='center' valign='top' style='padding: 40px 20px 10px 10px;'> </td> </tr></table> </td></tr><tr> <td bgcolor='#9bd3e9' align='center' style='padding: 0px 10px 0px 10px;'><table border='0' cellpadding='0' cellspacing='0' width='100%' style='max-width: 600px;'><tr> <td bgcolor='#ffffff' align='center' valign='top' style='padding: 40px 20px 10px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;'><h1 style='font-size: 48px; font-weight: 400; margin: 2px;'>Welcome!</h1> <img src='https://cdn.iconscout.com/icon/free/png-256/handshake-10-155089.png' width='125' height='120' style='display: block; border: 0px;' /></td></tr></table></td></tr><tr><td bgcolor='#f4f4f4' align='center' style='padding: 0px 50px 0px 50px;cellpadding:20; cellspacing:20; '><table border='0' cellpadding='20' width='100%' style='max-width: 600px;'><tr><td bgcolor='#ffffff' align='left' style='padding: 10px 30px 20px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;'> <p style='margin: 0;'>Hi<strong> ${lModuserlist[0].Pr_FullName} </strong> ,<br>I’m <strong> Khurram Sultan</strong>, the founder of <strong> Aisone Systems Team </strong>. I personally like to thank you for signing up to our services.We established our company in order to provide you the best services at a reliable cost. I would love to hear what you think about our products and suggestions in order to improve your experience.<br>Kindly use the following provided credentials to Sign in :<br/><strong>Email :</strong>${lModuserlist[0].Pr_EmailID}<br/><br><b> Click here to confirm your account.</b> <br></p></td></tr><tr><td bgcolor='#ffffff' align='left'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td bgcolor='#ffffff' align='center' style='padding: 2px 30px 30px 30px;'><table border='0' cellspacing='0' cellpadding='0'><tr><td align='center' style='border-radius: 3px;' bgcolor='#43add6'><a href='https://customerportal.aisonesystems.com/User/Fnc_UserApprovel?l_UserDID=${lModuserlist[0].Pr_PKGUID}' target='_blank' style='font-size: 20px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; text-decoration: none; color: #ffffff; text-decoration: none; padding: 15px 25px; border-radius: 2px; border: 1px solid #FFA73B; display: inline-block;'>Confirm Account</a></td></tr></table></td></tr></table></td></tr><tr><td bgcolor='#ffffff' align='left' style='padding: 0px 30px 20px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;'><p style='margin: 0;'>If you have any queries regarding our services, just feel free to contact us. </br> We're always happy to help you out.</p></td></tr><tr><td bgcolor='#ffffff' align='left' style='padding: 0px 30px 40px 30px; border-radius: 0px 0px 4px 4px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;'><p style='margin: 0;'><strong>Regards,<br>Aisone Systems Team.</strong></p></td></tr></table></td></tr></table></div>";

        cmGlobalVariables.Pb_HtmlString = lHtmlString;

      final tuple = await Sl_VerifyEmail().Fnc_VerifyEmail();


      if (tuple.item1 == "ok") {
        print("Email Send ");
        return true;
      } else {
        print(" Send: ${tuple.item2?.Pr_ExceptionMessage}");
        return false;
      }
    } catch (e) {
      print("User Email Failed: $e");
      return false;
    }
  }

  Future<bool> Fnc_UserCreate() async {
    try {
      final tuple = await Sl_UserCreate().Fnc_UserCreate();

      if (tuple.item1 == true) {
        print("User Created");
        return true;
      } else {
        print("User Not Created: ${tuple.item2?.Pr_ExceptionMessage}");
        return false;
      }
    } catch (e) {
      print("User Creation Failed: $e");
      return false;
    }
  }

  Future<bool> Fnc_CheckDuplicate() async {
    cmGlobalVariables.Pb_EmailID = Pr_txtemail_Text;
    try {
      final tuple = await Sl_Duplicate().Fnc_CheckDuplicateUser();

      if (tuple.item1 == true) {
        print("User found");
        return true;
      } else {
        print("User Not not found");
        return false;
      }
    } catch (e) {
      print("User not Failed: $e");
      return false;
    }
  }
}
