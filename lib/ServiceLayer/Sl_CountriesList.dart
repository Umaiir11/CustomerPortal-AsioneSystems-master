import 'dart:convert';

import '../ApiModels/ModCountry.dart';
import '../ApiModels/ModErrorLog.dart';
import '../ClassModules/cmHttpCalls.dart';
import 'package:tuple/tuple.dart';

class Sl_CountriesList {
  Future<Tuple2<List<ModCountry>?, ModErrorLog?>> Fnc_CountriesList() async {

    try {
      final lResponse = await cmHttpCalls().Fnc_HttpWebCountries('/apiWeb/NewCountryQuery/Get');
      if (lResponse.statusCode == 200) {
        var tuple = Fnc_JsonToTuple(jsonDecode(lResponse.body));
        print("Countries List");
        return Tuple2(tuple.item1, tuple.item2 ?? null); // assign null to Tuple2 if it is null
      } else {
        return Tuple2(null, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return Tuple2(null, null); // always return Tuple1

  }


  Tuple2<List<ModCountry>, ModErrorLog?> Fnc_JsonToTuple(Map<String, dynamic> lJsonObject) {
    List<dynamic> lJsonList = lJsonObject['Item1'];
    List<ModCountry> lListModCountryList = Fnc_JsonToListOfModel(lJsonList);

    ModErrorLog? lModErrorLog = null;
    if (lJsonObject.containsKey('Item2') && lJsonObject['Item2'] != null) {
      lModErrorLog = Fnc_JsonToErrorLogModel(lJsonObject['Item2']);
    }

    return Tuple2(lListModCountryList, lModErrorLog);
  }


  ModErrorLog Fnc_JsonToErrorLogModel(Map<String, dynamic> lJsonObject) {
    ModErrorLog lModErrorLog = ModErrorLog();
    lModErrorLog.Pr_ProjectName = lJsonObject["Pr_ProjectName"] ?? '0';
    lModErrorLog.Pr_ClassName = lJsonObject["Pr_ClassName"] ?? '0';
    lModErrorLog.Pr_MethodName = lJsonObject["Pr_MethodName"] ?? '0' ;
    lModErrorLog.Pr_ExceptionMessage = lJsonObject["Pr_ExceptionMessage"] ?? '0' ;
    lModErrorLog.Pr_InnerExceptionMessage = lJsonObject["Pr_InnerExceptionMessage"] ?? '0' ;
    lModErrorLog.Pr_LineNumber = lJsonObject["Pr_LineNumber"] ?? 0 ;
    lModErrorLog.Pr_ErrorCode = lJsonObject["Pr_ErrorCode"] ?? 0 ;
    lModErrorLog.Pr_ErrorTime =  DateTime.parse(lJsonObject["Pr_ErrorTime"] ??   "2022-08-13T13:49:44" );
    return lModErrorLog;
  }


  ModCountry Fnc_JsonToModel(Map<String, dynamic> lJsonObject) {
    ModCountry lModCountryList = ModCountry();

    lModCountryList.Pr_AutoID = lJsonObject["Pr_AutoID"]  ;
    lModCountryList.Pr_CountryCode = lJsonObject["Pr_CountryCode"];
    lModCountryList.Pr_CountryID = lJsonObject["Pr_CountryID"];
    return lModCountryList;
  }
  List<ModCountry> Fnc_JsonToListOfModel(List<dynamic> lJsonList) {
    List<ModCountry> lListModCountryList = List<ModCountry>.empty(growable: true);

    for (dynamic lJsonObject in lJsonList) {
      ModCountry lModCountryList = ModCountry();
      lModCountryList = Fnc_JsonToModel(lJsonObject);
      lListModCountryList.add(lModCountryList);
    }
    return lListModCountryList;
  }





}
