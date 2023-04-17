import 'dart:convert';

import 'package:get/get.dart';

import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/Model/ApiModels/ModErrorLog.dart';
import '../MVVM/Model/ApiModels/ModErrorLog.dart';
import '../MVVM/ViewModel/VmSignup.dart';
import 'package:tuple/tuple.dart';

class Sl_UserCreate {
  Future<Tuple2<bool?, ModErrorLog?>> Fnc_UserCreate() async {
    final VmSignUp l_VmSignUp = Get.find<VmSignUp>();

    try {
      String lJsonString = json.encode(l_VmSignUp.lModuserlist.map((e) => e.toJson()).toList());

      List<int> lUtfContent = utf8.encode(lJsonString);

      final lResponse = await cmHttpCalls().Fnc_HttpWeb('/apiWeb/User/PostUser', lUtfContent);
      print(lResponse);
      if (lResponse.statusCode == 200) {
        var tuple = Fnc_JsonToTuple(jsonDecode(lResponse.body));
        print("User Create");
        return Tuple2(tuple.item1, tuple.item2);
      } else {
        return const Tuple2(null, null);
      }
    } catch (e) {
      print(e.toString());
    }
    return const Tuple2(null, null);
  }

  Tuple2<bool?, ModErrorLog?> Fnc_JsonToTuple(Map<String, dynamic> lJsonObject) {
    final bool? l_UserCreated = lJsonObject['Item1'];
    ModErrorLog? lModErrorLog;
    if (lJsonObject['Item2'] != null) {
      lModErrorLog = Fnc_JsonToErrorLogModel(lJsonObject['Item2']);
    }
    return Tuple2(l_UserCreated, lModErrorLog);
  }

  ModErrorLog Fnc_JsonToErrorLogModel(Map<String, dynamic> lJsonObject) {
    ModErrorLog lModErrorLog = ModErrorLog();
    lModErrorLog.Pr_ProjectName = lJsonObject["Pr_ProjectName"];
    lModErrorLog.Pr_ClassName = lJsonObject["Pr_ClassName"];
    lModErrorLog.Pr_MethodName = lJsonObject["Pr_MethodName"];
    lModErrorLog.Pr_ExceptionMessage = lJsonObject["Pr_ExceptionMessage"];
    lModErrorLog.Pr_InnerExceptionMessage = lJsonObject["Pr_InnerExceptionMessage"];
    lModErrorLog.Pr_LineNumber = lJsonObject["Pr_LineNumber"];
    lModErrorLog.Pr_ErrorCode = lJsonObject["Pr_ErrorCode"];
    lModErrorLog.Pr_ErrorTime = lJsonObject["Pr_ErrorTime"];
    return lModErrorLog;
  }

}
