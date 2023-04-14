import 'dart:convert';

import 'package:login/ApiModels/ModUser.dart';

import '../ApiModels/ModCountry.dart';
import '../ApiModels/ModErrorLog.dart';
import '../ClassModules/cmHttpCalls.dart';
import 'package:tuple/tuple.dart';

class Sl_UserCreate {
  Future<bool> Fnc_UserCreate() async {

    DateTime expiredTime = DateTime.parse("1900-01-01T00:00:00");
    DateTime pkexpiredTime = DateTime.parse("2023-04-13T15:03:39.7042384+05:00");

    try {

      List<ModUser> lModuser = [
        ModUser(
          Pr_PKGUID: "7a6793d9-95aa-4682-867e-1fa763d02621",
          Pr_EmailID: "",
          Pr_FullName: "Pr_FullName",
          Pr_CountryDID: 0,
          Pr_CityDID: 0,
          Pr_Password: "",
          Pr_IsActivated: false,
          Pr_ContactNo: "",
          Pr_Token: "",
          Pr_ExpiredTime: expiredTime,
          Pr_Image: "",
          Pr_ImageExt: "",
          Pr_PackageDID: 0,
          Pr_NoOfLicences: 0,
          Pr_PerLicenceCost: 0.0,
          Pr_PurchasedProductDID: 0,
          Pr_PaidAmmount: 0.0,
          Pr_PackageExpiryDate: expiredTime,
          Pr_PackagePurchaseDate: expiredTime,
          Pr_CB: "00000000-0000-0000-0000-000000000000",
          Pr_CDate: pkexpiredTime,
          Pr_MB: "00000000-0000-0000-0000-000000000000",
          Pr_MDate: expiredTime,
          Pr_DB: "00000000-0000-0000-0000-000000000000",
          Pr_DDate: expiredTime,
          Pr_Operation: 0,
        ),
        // Add more ModUser models to the list as needed
      ];

      String lJsonString = json.encode(lModuser.map((e) => e.toJson()).toList());

      List<int> lUtfContent = utf8.encode(lJsonString);

      final lResponse = await cmHttpCalls().Fnc_HttpWeb('/apiWeb/NewUser/PostUser', lUtfContent);
      print(lResponse);
      if (lResponse.statusCode == 200) {
        return (jsonDecode(lResponse.body));
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true; // always return Tuple1

  }












}
