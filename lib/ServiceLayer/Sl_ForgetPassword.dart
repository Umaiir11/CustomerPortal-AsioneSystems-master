import 'dart:convert';

import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/Model/ApiModels/ModForgetPass.dart';

class Sl_ForgetPassword {
  Future<List<ModForgetPassword>?> Fnc_ForgetPassword() async {
    try {
      final lResponse = await cmHttpCalls().Fnc_HttpForgetPassword();
      if (lResponse.statusCode == 200) {
        return Fnc_JsonToListOfModel(jsonDecode(lResponse.body));
        print("Cities List");
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null; // always return Tuple1
  }

  ModForgetPassword Fnc_JsonToModel(Map<String, dynamic> lJsonObject) {
    ModForgetPassword lModForgetPassword = ModForgetPassword();

    lModForgetPassword.Pr_PKGUID = lJsonObject["Pr_PKGUID"];
    lModForgetPassword.Pr_EmailID = lJsonObject["Pr_EmailID"];
    lModForgetPassword.Pr_Password = lJsonObject["Pr_Password"];
    lModForgetPassword.Pr_FullName = lJsonObject["Pr_FullName"];
    lModForgetPassword.Pr_ContactNo = lJsonObject["Pr_ContactNo"];
    lModForgetPassword.Pr_Image = lJsonObject["Pr_Image"];
    lModForgetPassword.Pr_CountryDID = lJsonObject["Pr_CountryDID"];
    lModForgetPassword.Pr_CountryID = lJsonObject["Pr_CountryID"];
    lModForgetPassword.Pr_CityDID = lJsonObject["Pr_CityDID"];
    lModForgetPassword.Pr_CityID = lJsonObject["Pr_CityID"];
    lModForgetPassword.Pr_Token = lJsonObject["Pr_Token"];
    lModForgetPassword.Pr_ExpiredTime = DateTime.parse(lJsonObject["Pr_ExpiredTime"]);
    lModForgetPassword.Pr_IsActivated = lJsonObject["Pr_IsActivated"];
    lModForgetPassword.Pr_PackageID = lJsonObject["Pr_PackageID"];
    lModForgetPassword.Pr_PackageExpiryDate = DateTime.parse(lJsonObject["Pr_PackageExpiryDate"]);
    lModForgetPassword.Pr_PackagePurchaseDate = DateTime.parse(lJsonObject["Pr_PackagePurchaseDate"]);
    lModForgetPassword.Pr_PurchasedProductID = lJsonObject["Pr_PurchasedProductID"];
    lModForgetPassword.Pr_CDate = DateTime.parse(lJsonObject["Pr_CDate"]);
    lModForgetPassword.Pr_MB = lJsonObject["Pr_MB"];
    lModForgetPassword.Pr_MDate = DateTime.parse(lJsonObject["Pr_MDate"]);
    lModForgetPassword.Pr_DDate = DateTime.parse(lJsonObject["Pr_DDate"]);

    return lModForgetPassword;
  }

  //Method return list type
  List<ModForgetPassword> Fnc_JsonToListOfModel(List<dynamic> lJsonList) {
    List<ModForgetPassword> lListModForgetPassword = List<ModForgetPassword>.empty(growable: true);

    for (dynamic lJsonObject in lJsonList) {
      ModForgetPassword lModForgetPassword = ModForgetPassword();
      lModForgetPassword = Fnc_JsonToModel(lJsonObject);
      lListModForgetPassword.add(lModForgetPassword);
    }
    return lListModForgetPassword;
  }
}
