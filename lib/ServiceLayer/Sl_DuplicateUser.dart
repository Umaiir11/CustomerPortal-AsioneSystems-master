import 'dart:convert';

import 'package:login/ClassModules/cmGlobalVariables.dart';
import 'package:tuple/tuple.dart';

import '../ClassModules/cmHttpCalls.dart';
import '../MVVM/Model/ParameterModel/ModDuplicate.dart';

class Sl_Duplicate {
  Future<Tuple2<bool?, Map<String, dynamic>?>> Fnc_CheckDuplicateUser() async {
    try {
       ParModDuplicate lParModDuplicate = ParModDuplicate(
        Pr_EmailID: cmGlobalVariables.Pb_EmailID,
        Pr_Operation: 1,
      );

       String lJsonString = json.encode(lParModDuplicate.toJson());
       List<int> lUtfContent = utf8.encode(lJsonString);

      final  lResponse = await cmHttpCalls().Fnc_HttpWeb('/apiWeb/User/PostDuplicate?', lUtfContent);
      if (lResponse.statusCode == 200) {
         Map<String, dynamic> responseJson = json.decode(lResponse.body);
         bool? item1 = responseJson['Item1'];
         Map<String, dynamic>? item2 = responseJson['Item2']?.isNotEmpty == true ? responseJson['Item2'] : null;
        return Tuple2(item1, item2);
      }
    } catch (e) {
      print('Error: $e');
    }
    return Tuple2(null, null);
  }
}
