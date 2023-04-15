import 'dart:convert';

import 'package:tuple/tuple.dart';

import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/Model/ApiModels/ModCities.dart';
import '../MVVM/Model/ApiModels/ModErrorLog.dart';

class Sl_CitiesList {
  Future<Tuple2<List<ModCities>?, ModErrorLog?>> Fnc_CitiesList() async {

    try {
      final lResponse = await cmHttpCalls().Fnc_HttpWebCities();
      if (lResponse.statusCode == 200) {
        var tuple = Fnc_JsonToTuple(jsonDecode(lResponse.body));
        print("Cities List");
        return Tuple2(tuple.item1, tuple.item2 ?? null); // assign null to Tuple2 if it is null
      } else {
        return Tuple2(null, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return Tuple2(null, null); // always return Tuple1
  }

  Tuple2<List<ModCities>, ModErrorLog?> Fnc_JsonToTuple(Map<String, dynamic> lJsonObject) {
    List<dynamic> lJsonList = lJsonObject['Item1'];
    List<ModCities> lListModCitiesList = Fnc_JsonToListOfModel(lJsonList);

    ModErrorLog? lModErrorLog = null;
    if (lJsonObject.containsKey('Item2') && lJsonObject['Item2'] != null) {
      lModErrorLog = Fnc_JsonToErrorLogModel(lJsonObject['Item2']);
    }

    return Tuple2(lListModCitiesList, lModErrorLog);
  }

  ModErrorLog Fnc_JsonToErrorLogModel(Map<String, dynamic> lJsonObject) {
    ModErrorLog lModErrorLog = ModErrorLog();
    lModErrorLog.Pr_ProjectName = lJsonObject["Pr_ProjectName"] ?? '0';
    lModErrorLog.Pr_ClassName = lJsonObject["Pr_ClassName"] ?? '0';
    lModErrorLog.Pr_MethodName = lJsonObject["Pr_MethodName"] ?? '0';
    lModErrorLog.Pr_ExceptionMessage = lJsonObject["Pr_ExceptionMessage"] ?? '0';
    lModErrorLog.Pr_InnerExceptionMessage = lJsonObject["Pr_InnerExceptionMessage"] ?? '0';
    lModErrorLog.Pr_LineNumber = lJsonObject["Pr_LineNumber"] ?? 0;
    lModErrorLog.Pr_ErrorCode = lJsonObject["Pr_ErrorCode"] ?? 0;
    lModErrorLog.Pr_ErrorTime = DateTime.parse(lJsonObject["Pr_ErrorTime"] ?? "2022-08-13T13:49:44");
    return lModErrorLog;
  }

  ModCities Fnc_JsonToModel(Map<String, dynamic> lJsonObject) {
    ModCities lModCitiesList = ModCities();

    lModCitiesList.Pr_AutoID = lJsonObject["Pr_AutoID"];
    lModCitiesList.Pr_CityID = lJsonObject["Pr_CityID"];
    lModCitiesList.Pr_CountryDID = lJsonObject["Pr_CountryDID"];
    return lModCitiesList;
  }

  List<ModCities> Fnc_JsonToListOfModel(List<dynamic> lJsonList) {
    List<ModCities> lListModCitiesList = List<ModCities>.empty(growable: true);

    for (dynamic lJsonObject in lJsonList) {
      ModCities lModCitiesList = ModCities();
      lModCitiesList = Fnc_JsonToModel(lJsonObject);
      lListModCitiesList.add(lModCitiesList);
    }
    return lListModCitiesList;
  }
}
