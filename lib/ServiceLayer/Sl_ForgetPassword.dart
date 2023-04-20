import 'dart:convert';

import 'package:tuple/tuple.dart';

import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/Model/ApiModels/ModForgetPass.dart';

class Sl_ForgetPassword {
  Future<Tuple2<List<ModForgetPassword>?,  Map<String, dynamic>?>> Fnc_ForgetPassword() async {
    try {
      final lResponse = await cmHttpCalls().Fnc_HttpForgetPassword();
      if (lResponse.statusCode == 200) {
        var tuple = Fnc_JsonToTuple(jsonDecode(lResponse.body));
        print("Forget Pass");
        return Tuple2(tuple.item1, tuple.item2);
      } else {
        return const Tuple2(null, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return const Tuple2(null, null); // always return Tuple1
  }


  Tuple2<List<ModForgetPassword>,  Map<String, dynamic>?> Fnc_JsonToTuple(Map<String, dynamic> lJsonObject) {
    List<dynamic> lJsonList = lJsonObject['Item1'];
    List<ModForgetPassword> lListAssignedBranches = Fnc_JsonToListOfModel(lJsonList);
    Map<String, dynamic>? item2 = lJsonObject['Item2']?.isNotEmpty == true ? lJsonObject['Item2'] : null;
    return Tuple2(lListAssignedBranches, item2);
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
