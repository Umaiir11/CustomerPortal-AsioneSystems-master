class ModUser {
  String Pr_PKGUID = "7a6793d9-95aa-4682-867e-1fa763d02621";
  String Pr_EmailID = "";
  String Pr_FullName = "";
  int Pr_CountryDID = 0;
  int Pr_CityDID = 0;
  String Pr_Password = "";
  bool Pr_IsActivated = false;
  String Pr_ContactNo = "";
  String Pr_Token = "";
  DateTime Pr_ExpiredTime = DateTime.parse("2022-08-13T13:49:44");
  String Pr_Image = "";
  String Pr_ImageExt = "";
  int Pr_PackageDID = 0;
  int Pr_NoOfLicences = 0;
  double Pr_PerLicenceCost = 0.0;
  int Pr_PurchasedProductDID = 0;
  double Pr_PaidAmmount = 0.0;
  DateTime Pr_PackageExpiryDate = DateTime.parse("1900-01-01T00:00:00");
  DateTime Pr_PackagePurchaseDate = DateTime.parse("1900-01-01T00:00:00");
  String Pr_CB = "00000000-0000-0000-0000-000000000000";
  DateTime Pr_CDate = DateTime.parse("2023-04-13T15:03:39.7042384+05:00");
  String Pr_MB = "00000000-0000-0000-0000-000000000000";
  DateTime Pr_MDate = DateTime.parse("1900-01-01T00:00:00");
  String Pr_DB = "00000000-0000-0000-0000-000000000000";
  DateTime Pr_DDate = DateTime.parse("1900-01-01T00:00:00");
  int Pr_Operation = 0;


  Map<String, dynamic> toJson() {
    return {
      'Pr_PKGUID': Pr_PKGUID,
      'Pr_EmailID': Pr_EmailID,
      'Pr_FullName': Pr_FullName,
      'Pr_CountryDID': Pr_CountryDID,
      'Pr_CityDID': Pr_CityDID,
      'Pr_Password': Pr_Password,
      'Pr_IsActivated': Pr_IsActivated,
      'Pr_ContactNo': Pr_ContactNo,
      'Pr_Token': Pr_Token,
      'Pr_ExpiredTime': Pr_ExpiredTime.toIso8601String(),
      'Pr_Image': Pr_Image,
      'Pr_ImageExt': Pr_ImageExt,
      'Pr_PackageDID': Pr_PackageDID,
      'Pr_NoOfLicences': Pr_NoOfLicences,
      'Pr_PerLicenceCost': Pr_PerLicenceCost,
      'Pr_PurchasedProductDID': Pr_PurchasedProductDID,
      'Pr_PaidAmmount': Pr_PaidAmmount,
      'Pr_PackageExpiryDate': Pr_PackageExpiryDate.toIso8601String(),
      'Pr_PackagePurchaseDate': Pr_PackagePurchaseDate.toIso8601String(),
      'Pr_CB': Pr_CB,
      'Pr_CDate': Pr_CDate.toIso8601String(),
      'Pr_MB': Pr_MB,
      'Pr_MDate': Pr_MDate.toIso8601String(),
      'Pr_DB': Pr_DB,
      'Pr_DDate': Pr_DDate.toIso8601String(),
      'Pr_Operation': Pr_Operation,
    };
  }
}
