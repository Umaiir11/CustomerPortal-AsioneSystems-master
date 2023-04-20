import 'dart:convert';

import 'package:tuple/tuple.dart';

import '../ClassModules/cmGlobalVariables.dart';
import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/Model/ApiModels/ModErrorLog.dart';
import '../MVVM/Model/ParameterModel/Pr_ModEmailVerify.dart';

class Sl_VerifyEmail {
  Future<Tuple2<String?, ModErrorLog?>> Fnc_VerifyEmail() async {
    try {
      Pr_ModVerifyEmail lParModDuplicate = Pr_ModVerifyEmail(
        Pr_EmailTo: cmGlobalVariables.Pb_EmailID,
        Pr_Subject: "Email Verification",
        Pr_Body: cmGlobalVariables.Pb_HtmlString,
        Pr_Confirmation: "",
      );

      String lJsonString = json.encode(lParModDuplicate.toJson());
      List<int> lUtfContent = utf8.encode(lJsonString);
      final lResponse = await cmHttpCalls().Fnc_HttpWeb('/apiWeb/Email/Post', lUtfContent);
      print(lResponse);
      if (lResponse.statusCode == 200) {
        var tuple = Fnc_JsonToTuple(jsonDecode(lResponse.body));
        print("Send Email");
        return Tuple2(tuple.item1, tuple.item2);
      } else {
        return const Tuple2("ok", null);
      }
    } catch (e) {
      print(e.toString());
    }
    return const Tuple2("ok", null);
  }

  Tuple2<String?, ModErrorLog?> Fnc_JsonToTuple(Map<String, dynamic> lJsonObject) {
    final lUserCreated = lJsonObject['Item1']?.toString();
    ModErrorLog? lModErrorLog;
    if (lJsonObject['Item2'] != null) {
      lModErrorLog = Fnc_JsonToErrorLogModel(lJsonObject['Item2']);
    }
    return Tuple2(lUserCreated, lModErrorLog);
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
